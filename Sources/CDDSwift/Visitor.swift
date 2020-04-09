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

        var extractFields = ExtractVariables()
        node.walk(&extractFields)

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
			members: []
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
//	var members: [StructMember] = []

	func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
		return .skipChildren
	}
}
