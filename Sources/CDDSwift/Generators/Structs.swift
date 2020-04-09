import Foundation
import SwiftSyntax

func structDeclCodeBlock(structNode: StructNode) -> CodeBlockItemSyntax {
	let ident = structNode.ident
	let members = structNode.members

	return CodeBlockItemSyntax { builder in
		builder.useItem(StructDeclSyntax { builder in
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
		})
	}
}
