/// trim unnecessary characters from a string
func trim(_ string: String) -> String {
	return string
		.trimmingCharacters(in: .whitespacesAndNewlines)
		.replacingOccurrences(of: "\"", with: "")
}

extension String {
    var trimmedWhiteSpaces: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
