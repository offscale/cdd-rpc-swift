import Foundation

let env = ProcessInfo.processInfo.environment
let hostname: String! = env["HOST"] ?? "127.0.0.1"
let port: Int! = env["PORT"] != nil ? Int(env["PORT"]!) : 7781
RPCServer.start(hostname: hostname, port: port)
