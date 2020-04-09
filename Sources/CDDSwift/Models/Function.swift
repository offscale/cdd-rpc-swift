//
//  Function.swift
//  CDDSwift
//
//  Created by Rob Saunders on 8/4/20.
//

import Foundation

struct FunctionNode: Codable {
	var ident: String
	var params: [FunctionParam]
	var statements: [Member]
}

struct FunctionParam: Codable {
	var ident: String
	var type: String
	var isOptional: Bool?
}
