import Foundation
import SwiftSyntax



// code -> ast
func serialise(_ code: String) throws -> JSON {
//    let tree: [Node] = try parseCode(code)
	let file = FileNode(
		statements: [
			Statement.Struct(StructNode(ident: "Pet"))
		]
	)
	let jsonData: Data = try! JSONEncoder().encode(file)
    let json = try JSON(data: jsonData)
    return json
}

// ast -> code
func deserialise(ast: Data) throws -> String {
	let decoder = JSONDecoder()
	let file = try! decoder.decode(FileNode.self, from: ast)
	return print(fileNode: file)
}
