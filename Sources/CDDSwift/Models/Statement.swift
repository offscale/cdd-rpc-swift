//
//  Statement.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation

enum Statement {
	case Struct(StructNode)
	case Function(FunctionNode)
}

extension Statement: Codable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .Struct(let s):
            try container.encode(s, forKey: .structNode)
		case .Function(let f):
			try container.encode(f, forKey: .functionNode)
		}
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		if let structNodeValue = try container.decodeIfPresent(StructNode.self, forKey: .structNode) {
			self = .Struct(structNodeValue)
		} else if let functionNodeValue = try container.decodeIfPresent(FunctionNode.self, forKey: .functionNode) {
			self = .Function(functionNodeValue)
		} else {
			throw ParseError(message: "Invalid Parse")
		}
    }

	enum CodingKeys: String, CodingKey {
        case structNode, functionNode
    }
}

struct ParseError: Error {
	var message: String
}
