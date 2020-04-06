import Foundation
import SwiftSyntax

func extractModels(syntax: Syntax) throws -> [Model] {
    var models:[Model] = []
    var visitor = StructVisitor()
    // visitor.walk(syntax)
    syntax.walk(&visitor)

    for structure in visitor.structures {
        if structure.interfaces.contains("APIModel") {
            models.append(
                Model(
                    name: structure.name,
                    vars: structure.vars))
        }
    }
    return models
}