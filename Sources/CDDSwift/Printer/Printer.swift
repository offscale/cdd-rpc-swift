//
//  Printer.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation

func print(fileNode: FileNode) -> String {
	return fileNode.statements.map({ statement in
		switch statement {
		case .Struct(let structNode):
			return structDeclCodeBlock(structNode: structNode).description;
		case .Function(let functionNode):
			return functionDeclCodeBlock(function: functionNode).description;
		}
		}).joined(separator: "\n\n")
}
