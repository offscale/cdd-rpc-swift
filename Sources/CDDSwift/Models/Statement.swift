//
//  Statement.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation

enum Statement: Codable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .Struct(let s):
            try container.encode(s, forKey: .structNode)
        }
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)

        do {
			let s =  try! values.decode( StructNode.self, forKey: .structNode)
            self = .Struct(s)
        }
    }

	enum CodingKeys: CodingKey {
        case structNode
    }

	case Struct(StructNode)
}
