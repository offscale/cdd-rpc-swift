import WebSocket

struct EchoResponder: HTTPServerResponder {
    /// See `HTTPServerResponder`.
    func respond(to req: HTTPRequest, on worker: Worker) -> Future<HTTPResponse> {
        // Create an HTTPResponse with the same body as the HTTPRequest
        let res = HTTPResponse(body: req.body)
        // We don't need to do any async work here, we can just
        // se the Worker's event-loop to create a succeeded future.
        return worker.eventLoop.newSucceededFuture(result: res)
    }
}

class Server {
    static func start(hostname: String, port: Int) {
        print("Starting server on \(hostname):\(port)...")

        let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

        do {
            let server = try HTTPServer.start(
                hostname: hostname, 
                port: port, 
                responder: EchoResponder(), 
                on: group
            ).wait()
            try server.onClose.wait()
        } catch {
            print("error")
        }
    }
}
