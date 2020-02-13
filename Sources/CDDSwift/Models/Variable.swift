struct Variable: Codable {
	var name: String
	var optional: Bool
	var type: VarType
	var value: String?
	var description: String?
}