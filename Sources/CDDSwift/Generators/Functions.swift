import Foundation
import SwiftSyntax

func functionCallCodeBlock(functionName: String, functionParam: String) -> CodeBlockItemSyntax {
	let string = SyntaxFactory.makeStringLiteralExpr(functionName)
	let printID = SyntaxFactory.makeVariableExpr(functionParam)
	let arg = FunctionCallArgumentSyntax {
		$0.useExpression(string)
	}
	let call = FunctionCallExprSyntax {
		$0.useCalledExpression(printID)
		$0.useLeftParen(SyntaxFactory.makeLeftParenToken())
		$0.addArgument(arg)
		$0.useRightParen(SyntaxFactory.makeRightParenToken())
	}
	return CodeBlockItemSyntax {
		$0.useItem(call)
	}
}

func functionDeclCodeBlock(function: FunctionNode) -> CodeBlockItemSyntax {

	return CodeBlockItemSyntax { builder in
		builder.useItem(FunctionDeclSyntax { fBuilder in

			// ident
			fBuilder.useIdentifier(SyntaxFactory.makeIdentifier(function.ident))

			// func keyword
			fBuilder.useFuncKeyword(SyntaxFactory.makeFuncKeyword(leadingTrivia: Trivia(pieces: [.newlines(1), .tabs(1)]), trailingTrivia: .spaces(1)))

			// body
			fBuilder.useBody(SyntaxFactory.makeCodeBlock(
				leftBrace: SyntaxFactory.makeLeftBraceToken(leadingTrivia: .spaces(1)),
				statements: SyntaxFactory.makeCodeBlockItemList([]),
				rightBrace: SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
			))

			// params
			fBuilder.useSignature(FunctionSignatureSyntax { sBuilder in
				sBuilder.useInput(ParameterClauseSyntax { pBuilder in

					for (index, param) in function.params.enumerated() {
						pBuilder.addParameter(
							functionParameter(
								name: param.ident,
								type: param.type,
								useTrailingComma: (index < function.params.count - 1)
						))
					}

					pBuilder.useLeftParen(SyntaxFactory.makeLeftParenToken())
					pBuilder.useRightParen(SyntaxFactory.makeRightParenToken(
						leadingTrivia: .zero, trailingTrivia: .spaces(1)))
				})
			})

			// return type

		})
	}
}

func functionParameter(name: String, type: String, useTrailingComma: Bool) -> FunctionParameterSyntax {
	return FunctionParameterSyntax { builder in
		builder.useFirstName(SyntaxFactory.makeIdentifier(name))
		builder.useType(variableType(type, isOptional: false))
		builder.useColon(SyntaxFactory.makeColonToken(leadingTrivia: .zero, trailingTrivia: .spaces(1)))
		if useTrailingComma {
			builder.useTrailingComma(SyntaxFactory.makeCommaToken(leadingTrivia: .zero, trailingTrivia: .spaces(1)))
		}
	}
}

//func variableParam(optional: bool, hasDefault: bool) -> TypeAnnotationSyntax {
//	let colon = SyntaxFactory.makeColonToken(leadingTrivia: .zero,
//											 trailingTrivia: .spaces(1))
//	var typeAnnotation: TypeSyntax?
//	if optional {
//		let questionMark = SyntaxFactory.makePostfixQuestionMarkToken(leadingTrivia: .zero, trailingTrivia: hasDefault ? .spaces(1) : .zero)
//		typeAnnotation = SyntaxFactory.makeOptionalType(wrappedType: type.libRepresentation(),
//														questionMark: questionMark)
//	} else {
//		typeAnnotation = type.libRepresentation(hasDefault: hasDefault)
//	}
//	return SyntaxFactory.makeTypeAnnotation(colon: colon,
//											type: typeAnnotation!)
//}

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
