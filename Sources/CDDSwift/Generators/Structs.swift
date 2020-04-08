import Foundation
import SwiftSyntax

func structCodeBlock(name: String, type: String, members: [MemberDeclListItemSyntax]) -> StructDeclSyntax {
    let typeSyntax = TypeInheritanceClauseSyntax {
        $0.useColon(
			SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1)).withLeadingTrivia(.spaces(1))
		)
        $0.addInheritedType(
			SyntaxFactory.makeInheritedType(typeName: SyntaxFactory.makeTypeIdentifier(type), trailingComma: nil)
		)
    }

	let contentBlock = SyntaxFactory.makeMemberDeclBlock(
		leftBrace: SyntaxFactory.makeLeftBraceToken(leadingTrivia: .spaces(1)),
		members: SyntaxFactory.makeMemberDeclList(members),
		rightBrace: SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
	)

    let structSyntax = SyntaxFactory.makeStructDecl(attributes: nil,
		modifiers: nil,
		structKeyword: SyntaxFactory.makeStructKeyword(),
		identifier: SyntaxFactory.makeIdentifier(name).withLeadingTrivia(.spaces(1)),
		genericParameterClause: nil,
		inheritanceClause: typeSyntax,
		genericWhereClause: nil,
		members: contentBlock)

    return structSyntax
}
