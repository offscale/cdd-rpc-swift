import SwiftSyntax

struct Structure {
    let name: String
    var interfaces: [String] = []
    var vars: [Variable] = []
    var typeAliases: [String:String] = [:]
    init(name: String) {
        self.name = name
    }
}

class StructVisitor : SyntaxVisitor {
    var structures: [Structure] = []
    var syntaxes: [String:StructDeclSyntax] = [:]
    
    func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = "\(node.identifier)".trimmingCharacters(in: .whitespaces)
        var structure = Structure(name: structName)
        
        for member in node.children {
            if type(of: member) == TypeInheritanceClauseSyntax.self {
                for child in member.children {
                    if type(of: child) == InheritedTypeListSyntax.self {
                        structure.interfaces.append(trim("\(child)"))
                    }
                }
            }
        }
        var extractFields = ExtractVariables()
        node.walk(&extractFields)
        structure.vars = extractFields.variables
        
        // let extractAliases = ExtractTypealiases()
        // node.walk(extractAliases)
        // structure.typeAliases = extractAliases.aliases
        
        
        structures.append(structure)
        // syntaxes[klass.name] = node
        
        return .skipChildren
    }
}

