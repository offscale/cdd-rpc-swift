import Foundation
import SwiftSyntax

func update(project: Project, code: String) -> String {
    if code == "" {
        return printProject(project)
    }
    return code
}

func parse(code: String) throws -> Project {
    // if code == "" {
    //     return printProject(project)
    // }
    return try parseProject(code)
}

// code -> ast
func serialise(_ code: String) throws -> JSON {
    let tree: [Node] = try parseCode(code)
    let jsonData: Data = try! JSONEncoder().encode(tree)
    let json = try JSON(data: jsonData)
    return json
}

func deserialise(ast: JSON) throws -> String {
  let code: String = try! JSONDecoder().decode(SyntaxParser.self, from: ast)
  return "code"
}
