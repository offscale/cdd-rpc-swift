import WebSocket

class RPCServer {
    static func start(hostname: String, port: Int) {
        print("Listening rpc socket server on \(hostname):\(port)...")

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
                        let project = json["params"]["project"]
                        let code = json["code"].stringValue
                        let id = json["id"].stringValue

                        switch json["method"] {

                        case "update":
                            print("update: \(json)")
                            let code: String = update(project: project, code: code)
                            let response: JSON = rpc_response(result: ["code": code], id: id)

                            print("response: \(response)")
                            ws.send(response.description)

                                
                        default: ()
                        }

                        // print("in: method: \(json["method"])")
                        // print("DONE \(json)")
                    } catch {}
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
            print("error")
        }
    }
}

func update(project: JSON, code: String) -> String {
    if code == "" {
        return printModel()
    }
    return code
}

func rpc_response(result: JSON, id: String) -> JSON {
    [
        "jsonrpc": "2.0",
        "result": result,
        "id": id
    ]
}