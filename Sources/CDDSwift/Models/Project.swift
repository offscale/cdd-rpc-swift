import Foundation

struct Project: Codable {
	var models: [Model]
    // var requests: [Request]
}

extension Decodable {
    static func from(json: String) throws -> Self {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode(Self.self, from: data)
    }
}


extension Encodable {
    func json() throws -> String {
        let data = try JSONEncoder().encode(self)
        
        return String(data: data, encoding: .utf8) ?? ""
    }
}
