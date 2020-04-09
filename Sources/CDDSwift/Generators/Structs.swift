import Foundation
import SwiftSyntax

func structDeclCodeBlock(structNode: StructNode) -> StructDeclSyntax {
	let ident = structNode.ident
	let members = structNode.members

	return StructDeclSyntax { builder in
		builder.useStructKeyword(SyntaxFactory.makeStructKeyword())
		builder.useIdentifier(SyntaxFactory.makeIdentifier(ident).withLeadingTrivia(.spaces(1)))
		builder.useMembers(
			MemberDeclBlockSyntax { mBuilder in
				mBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(leadingTrivia: .spaces(1)))
				mBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1)))
				for member in members {
					mBuilder.addMember(memberDeclListItem(member: member))
				}
			}
		)
	}
}

func memberDeclListItem(member: StructMember) -> MemberDeclListItemSyntax {
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
