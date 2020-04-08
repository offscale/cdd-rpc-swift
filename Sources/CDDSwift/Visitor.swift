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

		statements.append(Statement.Struct(StructNode(
			ident: ident,
			statements: []
		)))
		
		return .skipChildren
	}
}
