import SwiftSyntax

class ExtractVariables : SyntaxVisitor {
	var variables: [Variable] = []

	func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    
        var variable: Variable?
        
		for child in node.children {
			if type(of: child) == IdentifierPatternSyntax.self {
                if let variable = variable {
                    variables.append(variable)
                }
                variable = Variable(name:"\(child)".trimmedWhiteSpaces, optional: false, type: .primitive(.String), value: nil, description: nil)
			}
            
			if type(of: child) == InitializerClauseSyntax.self {
					for c in child.children {
                        var value = "\(c)".trimmedWhiteSpaces
						if type(of: c) == StringLiteralExprSyntax.self {
                            variable?.type = .primitive(.String)
                            value = value.replacingOccurrences(of: "\"", with: "")
                        }
                        else if type(of: c) == IntegerLiteralExprSyntax.self {
                            variable?.type = .primitive(.Int)
                        }
                        else if type(of: c) == BooleanLiteralExprSyntax.self {
                            variable?.type = .primitive(.Bool)
                        }
                        else if type(of: c) == FloatLiteralExprSyntax.self {
                            variable?.type = .primitive(.Float)
                        }
                        
                        variable?.value = value
					}
			}
            
            if type(of: child) == TypeAnnotationSyntax.self {
                let type = "\(child)".replacingOccurrences(of: ":", with: "").trimmedWhiteSpaces
                variable?.optional = type.suffix(1) == "?"
                variable?.type = typeFor(type: type.replacingOccurrences(of: "?", with: ""))
            }
            

            if type(of: child) == CodeBlockSyntax.self {
                for c in child.children {
                    if type(of: c) == CodeBlockItemListSyntax.self {
                        let walkers = [ExtractComlexPath(),ExtractMethodType(),ExtractReturnValue()]
                        walkers.forEach {
                            if let value = $0.walk(in: c) {
                                variable?.value = value
                            }
                        }
                    }
                }
            }
		}
        
        if let variable = variable {
            variables.append(variable)
        }
        
		return .skipChildren
	}
    
    func typeFor(type:String) -> VarType {
        guard type.first != "["  else {
            let inType = String(type.dropFirst().dropLast())
            return VarType.array(typeFor(type: inType))
        }
        switch type {
        case "String":
            return .primitive(.String)
        case "Int":
            return .primitive(.Int)
        case "Bool":
            return .primitive(.Bool)
        case "Float":
            return .primitive(.Float)
        default:
            return .complex(type)
        }
    }
}
