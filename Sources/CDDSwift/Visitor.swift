//
//  Visitor.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import SwiftSyntax

class StatementVisitor : SyntaxVisitor {
	var statements: [Statement] = []

	func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
		let ident = "\(node.identifier)".trimmingCharacters(in: .whitespaces)

//		print(node)

        var visitor = ExtractVariables()
        node.walk(&visitor)

		// members
//		var pbVisitor = PatternBindingVisitor()
//		node.walk(&pbVisitor)

//        for member in node.children {
//			// inheritance clauses
////            if type(of: member) == TypeInheritanceClauseSyntax.self {
////                for child in member.children {
////                    if type(of: child) == InheritedTypeListSyntax.self {
////                        structure.interfaces.append(trim("\(child)"))
////                    }
////                }
////            }
//
//
//        }

		statements.append(Statement.Struct(StructNode(
			ident: ident,
			members: visitor.members
		)))

		return .skipChildren
	}

	func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
		let ident = "\(node.identifier)".trimmingCharacters(in: .whitespaces)

		statements.append(Statement.Function(FunctionNode(
			ident: ident,
			params: [],
			statements: []
		)))

		return .skipChildren
	}
}

class ExtractVariables : SyntaxVisitor {
	var members: [StructMember] = []

	func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
		var visitor = ExtractVariable()
        node.walk(&visitor)

		print("IDENT: ", visitor.ident, visitor.type, visitor.isOptional)
		if let ident = visitor.ident {
			if let type = visitor.type {
				members.append(StructMember(
					ident: ident,
					type: type
				))
			}
		}

		return .skipChildren
	}
}

class ExtractVariable : SyntaxVisitor {
	var type: String?
	var ident: String?
	var isOptional: Bool = false

	func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
		ident = "\(node.identifier)".trimmingCharacters(in: .whitespaces)
		return .skipChildren
	}

	func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
		type = "\(node)".replacingOccurrences(of: ":", with: "").trimmedWhiteSpaces
		return .skipChildren
	}
}
