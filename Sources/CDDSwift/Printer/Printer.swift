//
//  Printer.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation
import SwiftSyntax

func print(fileNode: FileNode) -> String {
	return statementsToNodes(statements: fileNode.statements).map({ nodes in
		nodes.description
	}).joined(separator: "\n\n");
}

func statementsToNodes(statements: [Statement]) -> [CodeBlockItemSyntax] {
	return statements.map(statementToNodes)
}

func statementToNodes(statement: Statement) -> CodeBlockItemSyntax {
	switch statement {
	case .Struct(let structNode):
		return structDeclCodeBlock(structNode: structNode);
	case .Function(let functionNode):
		return functionDeclCodeBlock(function: functionNode);
	}
}
