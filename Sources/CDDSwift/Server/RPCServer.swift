import WebSocket

class RPCServer {
    static func start(hostname: String, port: Int) {
        print("Listening rpc socket server on \(hostname):\(port)...")

        let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

        let ws = HTTPServer.webSocketUpgrader(shouldUpgrade: { req in
            print("in: method: \(req.url.path)")
            // Returning nil in this closure will reject upgrade
            if req.url.path == "/deny" { return nil }
            // Return any additional headers you like, or just empty
            return [:]
        }, onUpgrade: { ws, req in
            // This closure will be called with each new WebSocket client
            ws.send("Connected")
            ws.onText { ws, string in
                ws.send(string.reversed())
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
    