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
            // Return any additional headers
            return [:]
        }, onUpgrade: { ws, req in
            ws.onText { ws, string in

                if let dataFromString = string.data(using: .utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        let id = json["id"].stringValue

						do {
							switch json["method"] {
							case "serialise":
								print("-> serialise: \(json)")

								let code: String = json["params"]["code"].stringValue
								let json: JSON = try serialise(code: code)
								let response: JSON = rpc_response(result: ["ast": json], id: id)

								print("<- serialise: \(response)")
								ws.send(response.description)

							case "deserialise":
								print("-> deserialise: \(json)")

								let ast = json["params"]["ast"]
								let code:String = try deserialise(ast: ast.rawData())
								let response: JSON = rpc_response(result: ["code": code], id: id)

								ws.send(response.description)

							default: ()
							}
						} catch let e {
							let response: JSON = rpc_error(message: "rpc method error: \(e)", id: id)
							ws.send(response.description)
						}


                        // print("in: method: \(json["method"])")
                        // print("DONE \(json)")
                    } catch let e {
                        fputs("error encountered during JSON dance.: \(e)\n", stderr)
						let response: JSON = rpc_error(message: "error parsing basic json 2.0 request: \(e)", id: "0")
						ws.send(response.description)
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

func rpc_error(message: String, id: String) -> JSON {
	[
		"jsonrpc": "2.0",
		"id": id,
		"error": [
			"code": -32700, // parse error
			"message": message
		]
	]
}
