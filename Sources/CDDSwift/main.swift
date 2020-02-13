// import SwiftSyntax
import Foundation

let env = ProcessInfo.processInfo.environment

let hostname: String! = env["HOST"] != nil ? env["HOST"] : "localhost"
let port: Int! = env["PORT"] != nil ? Int(env["PORT"]!) : 7781

RPCServer.start(hostname: hostname, port: port)
