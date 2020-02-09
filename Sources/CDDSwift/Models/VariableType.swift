
indirect enum VarType: Equatable, Codable {
    case primitive(PrimitiveType)
    case array(VarType)
    case complex(String)
    
    enum CodingKeys: String, CodingKey {
        case array
        case primitive
        case complex
    }

    public func toString() -> String {
        switch self {
            case .primitive(let pt):
                return "\(pt)"
            default:
                return "Unsupported"
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .primitive(let type):
            try type.encode(to: encoder)
//            try container.encode(type, forKey: .primitive)
        case .array(let type):
            let str = try type.json()
            try str.encode(to: encoder)
//            try container.encode(type, forKey: .array)
        case .complex(let type):
            try type.encode(to: encoder)
//            try container.encode(type, forKey: .complex)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        self = VarType.decode(str:str)
    }
    
    private static func decode(str: String) -> VarType {
        var str = str
        switch str {
        case "Int": return .primitive(.Int)
        case "String": return .primitive(.String)
        case "Float": return .primitive(.Float)
        case "Bool": return .primitive(.Bool)
        default:
            if String(str.suffix(1)) == "[" {
                str = String(str.suffix(str.count - 1))
                str = String(str.prefix(str.count - 1))
                return .array(decode(str: str))
            }
            else {
                return .complex(str)
            }
        }
    }
}

enum PrimitiveType: String, Codable {
    case String
    case Int
    case Float
    case Bool
}

