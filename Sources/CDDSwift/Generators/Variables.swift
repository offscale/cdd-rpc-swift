import Foundation
import SwiftSyntax

func memberDeclListItem(member: Member) -> MemberDeclListItemSyntax {
	let ident = member.ident
	let type = member.type

	return MemberDeclListItemSyntax { builder in
		builder.useDecl(VariableDeclSyntax { vBuilder in
			vBuilder.useLetOrVarKeyword(SyntaxFactory.makeVarKeyword(
				leadingTrivia: Trivia(pieces: [.newlines(1), .tabs(1)]),
				trailingTrivia: .spaces(1)))
			vBuilder.addBinding(PatternBindingSyntax { pbBuilder in
				pbBuilder.usePattern(SyntaxFactory.makeIdentifierPattern(
					identifier: SyntaxFactory.makeIdentifier(ident)))
				pbBuilder.useTypeAnnotation(typeAnnotation(ident: type, isOptional: false, hasDefault: false))
			})
		})
	}
}
