import Foundation
import SwiftSyntax

func parseProject(_ code: String) throws -> Project {
    let syntax = try SyntaxParser.parse(source: code)

    return Project(models: try extractModels(syntax: syntax))
}

func parseCode(_ code: String) throws -> [Node] {
    let syntax = try SyntaxParser.parse(source: code)
    let nodes = try extractAll(syntax: syntax)

    return nodes
}
