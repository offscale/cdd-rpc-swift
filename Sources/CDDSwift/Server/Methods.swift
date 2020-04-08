import Foundation
import SwiftSyntax



// code -> ast
func serialise(code: String) throws -> JSON {
	let file: FileNode = try parseFile(code: code)
	let jsonData: Data = try! JSONEncoder().encode(file)
    let json = try JSON(data: jsonData)
    return json
}

// ast -> code
func deserialise(ast: Data) throws -> String {
	let decoder = JSONDecoder()
	let file = try decoder.decode(FileNode.self, from: ast)
	return print(fileNode: file)
}
