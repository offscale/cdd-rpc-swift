import Foundation
import SwiftSyntax

func functionCodeBlock(functionName: String, functionParam: String) -> CodeBlockItemSyntax {
	let string = SyntaxFactory.makeStringLiteralExpr(functionName)
	let printID = SyntaxFactory.makeVariableExpr(functionParam)
	let arg = FunctionCallArgumentSyntax {
		$0.useExpression(string)
	}
	let call = FunctionCallExprSyntax {
		$0.useCalledExpression(printID)
		$0.useLeftParen(SyntaxFactory.makeLeftParenToken())
		$0.addFunctionCallArgument(arg)
		$0.useRightParen(SyntaxFactory.makeRightParenToken())
	}
	return CodeBlockItemSyntax {
		$0.useItem(call)
	}
}