//
//  Parser.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import SwiftSyntax

func parseFile(code: String) throws -> FileNode {
	let syntax = try SyntaxParser.parse(source: code)
	var visitor = StatementVisitor()
	syntax.walk(&visitor)
	return FileNode(statements: visitor.statements)
}
