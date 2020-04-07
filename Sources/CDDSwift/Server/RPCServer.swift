import WebSocket
import SwiftSyntax

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

                            // let tree: [Node] = try parseCode(code)
                            // // convert to json data
                            // let jsonData: Data = try! JSONEncoder().encode(tree)
                            // let json = try JSON(data: jsonData)
                            let response: JSON = rpc_response(result: ["ast": json], id: id)
                            print("<- serialise: \(response)")
                            ws.send(response.description)

                        case "deserialise":
                            print("-> deserialise: \(json)")
                            // let ast:JSON = json["params"]["ast"]
                            // let source:[Node] = try! JSONDecoder().decode(Node.self, from: ast.data)
                            
                            // let response: JSON = rpc_response(result: ["ast": ast], id: id)
                            // ws.send(response.description)

                        case "update":
                            print("update: \(json)")
                            let projectJson = json["params"]["project"]
                            let project = try JSONDecoder().decode(Project.self, from: "\(projectJson)");

                            let code: String = update(project: project, code: code)
                            let response: JSON = rpc_response(result: ["code": code], id: id)
                            print("response: \(response)")
                            ws.send(response.description)

                        case "parse":
                            print("parse: \(json)")
                            let project: Project = try parse(code: code)
                            print("project: \(project)")
                            let projectData:Data = try JSONEncoder().encode(project)
                            let json = try JSON(data: projectData)

                            let response: JSON = rpc_response(result: ["project": json], id: id)
                            print("response: \(response)")
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

// func decodeProject(json: JSON) throws -> Project? {
//     return try JSONDecoder().decode(Project, from: json)
// }

// struct RPCResponse<T>: Codable {
//     var jsonrpc: String
//     var result: T:Codable
//     var id: String
// }
