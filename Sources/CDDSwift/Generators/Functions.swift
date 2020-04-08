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

func functionDeclCodeBlock(functionName: String) -> CodeBlockItemSyntax {
	let ident = SyntaxFactory.makeIdentifier(functionName)

	let body = SyntaxFactory.makeCodeBlock(
		leftBrace: SyntaxFactory.makeLeftBraceToken(leadingTrivia: .spaces(1)),
		statements: SyntaxFactory.makeCodeBlockItemList([]),
		rightBrace: SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
	)

	let defn = FunctionDeclSyntax {
		$0.useFuncKeyword(SyntaxFactory.makeFuncKeyword(
			leadingTrivia: Trivia(pieces: [.newlines(1), .tabs(1)]),
			trailingTrivia: .spaces(1)))
		$0.useIdentifier(ident)
		$0.useBody(body)
	}

	return CodeBlockItemSyntax {
		$0.useItem(defn)
	}
}
