//
//  Struct.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation

struct StructNode: Codable {
	var ident: String
	var members: [StructMember]
}

struct StructMember: Codable {
	var ident: String
	var type: String
	var isOptional: Bool?
}
