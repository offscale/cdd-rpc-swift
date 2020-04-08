import WebSocket
import SwiftSyntax
import Foundation

class RPCServer {
    static func start(hostname: String, port: Int) {
        print("Swift JSON-RPC socket server listening on \(hostname):\(port)…")

        let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

        let ws = HTTPServer.webSocketUpgrader(shouldUpgrade: { req in
            // Returning nil in this closure will reject upgrade
            if req.url.path == "/deny" { return nil }
            // Return any additional headers you like, or just empty
            return [:]
        }, onUpgrade: { ws, req in
            // This closure will be called with each new WebSocket client

            // ws.send("Connected")
            ws.onText { ws, string in
                // print("body: \(string)")

                if let dataFromString = string.data(using: .utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        let code = json["code"].stringValue
                        let id = json["id"].stringValue

                        switch json["method"] {

                        case "serialise":
                            print("-> serialise: \(json)")

                            let code: String = json["params"]["code"].stringValue
                            let json: JSON = try serialise(code)
                            let response: JSON = rpc_response(result: ["ast": json], id: id)

                            print("<- serialise: \(response)")
                            ws.send(response.description)

                        case "deserialise":
                            print("-> deserialise: \(json)")

							let ast = json["params"]["ast"]
							let code:String = try! deserialise(ast: ast.rawData())
							let response: JSON = rpc_response(result: ["code": code], id: id)
							
							ws.send(response.description)
                                
                        default: ()
                        }

                        // print("in: method: \(json["method"])")
                        // print("DONE \(json)")
                    } catch {
                        fputs("error encountered during JSON dance.\n", stderr)
                    }
                }
            }
        })

        do {
            // Next, create your server, adding the WebSocket upgrader
            let server = try HTTPServer.start(
                hostname: hostname,
                port: port,
                responder: EchoResponder(),
                upgraders: [ws],
                on: group
            ).wait()
            // Run the server.
            try server.onClose.wait()
        } catch {
            fputs("error encountered during HTTP server starting|stopping.\n", stderr)
        }
    }
}

func rpc_response(result: JSON, id: String) -> JSON {
    [
        "jsonrpc": "2.0",
        "result": result,
        "id": id
    ]
}
