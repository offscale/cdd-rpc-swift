import Foundation
import SwiftSyntax

//func sstructDeclCodeBlock(name: String, type: String, members: [MemberDeclListItemSyntax]) -> StructDeclSyntax {
//    let typeSyntax = TypeInheritanceClauseSyntax {
//        $0.useColon(
//			SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1)).withLeadingTrivia(.spaces(1))
//		)
//        $0.addInheritedType(
//			SyntaxFactory.makeInheritedType(typeName: SyntaxFactory.makeTypeIdentifier(type), trailingComma: nil)
//		)
//    }
//
//	let contentBlock = SyntaxFactory.makeMemberDeclBlock(
//		leftBrace: SyntaxFactory.makeLeftBraceToken(leadingTrivia: .spaces(1)),
//		members: SyntaxFactory.makeMemberDeclList(members),
//		rightBrace: SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
//	)
//
//    let structSyntax = SyntaxFactory.makeStructDecl(attributes: nil,
//		modifiers: nil,
//		structKeyword: SyntaxFactory.makeStructKeyword(),
//		identifier: SyntaxFactory.makeIdentifier(name).withLeadingTrivia(.spaces(1)),
//		genericParameterClause: nil,
//		inheritanceClause: typeSyntax,
//		genericWhereClause: nil,
//		members: contentBlock)
//
//    return structSyntax
//}

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
			vBuilder.useLetOrVarKeyword(SyntaxFactory.makeVarKeyword())
			vBuilder.addBinding(PatternBindingSyntax { pbBuilder in
				pbBuilder.usePattern(SyntaxFactory.makeIdentifierPattern(
					identifier: SyntaxFactory.makeIdentifier(ident)))
				pbBuilder.useTypeAnnotation(typeAnnotation(ident: type, isOptional: false, hasDefault: false))
			})
		})
	}
}
