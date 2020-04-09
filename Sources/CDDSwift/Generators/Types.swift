//
//  Types.swift
//  CDDSwift
//
//  Created by Rob Saunders on 9/4/20.
//

import Foundation
import SwiftSyntax

func variableType(_ name: String, isOptional: Bool, hasDefault: Bool = false) -> OptionalTypeSyntax {
	return OptionalTypeSyntax { builder in
		builder.useWrappedType(SimpleTypeIdentifierSyntax { sBuilder in
			sBuilder.useName(SyntaxFactory.makeIdentifier(name, leadingTrivia: .zero, trailingTrivia: hasDefault ? .spaces(1) : .zero))
		})
		if isOptional {
			builder.useQuestionMark(SyntaxFactory.makePostfixQuestionMarkToken())
		}
	}
}

func typeAnnotation(ident: String, isOptional: Bool, hasDefault: Bool) -> TypeAnnotationSyntax {
	let colon = SyntaxFactory.makeColonToken(leadingTrivia: .zero,
											 trailingTrivia: .spaces(1))
	var typeAnnotation: TypeSyntax?
	if isOptional {
		let questionMark = SyntaxFactory.makePostfixQuestionMarkToken(leadingTrivia: .zero, trailingTrivia: hasDefault ? .spaces(1) : .zero)
		typeAnnotation = SyntaxFactory.makeOptionalType(wrappedType: variableType(ident, isOptional: isOptional), questionMark: questionMark)
	} else {
		typeAnnotation = variableType(ident, isOptional: isOptional, hasDefault: hasDefault)
	}
	return SyntaxFactory.makeTypeAnnotation(colon: colon,
											type: typeAnnotation!)
}
