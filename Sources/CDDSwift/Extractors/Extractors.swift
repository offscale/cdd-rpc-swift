import SwiftSyntax

class ValueVisitor: SyntaxVisitor {
    var value: String?
    func walk(in child:Syntax) -> String? {
        // child.walk(&self)
        return self.value
    }
}

class ExtractReturnValue : ValueVisitor {
    func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
        self.value = trim("\(node)")
        return .skipChildren
    }
}

class ExtractComlexPath : ValueVisitor {
    
    // func visit(_ node: StringInterpolationSegmentsSyntax) -> SyntaxVisitorContinueKind {
    //     self.value = trim("\(node)").replacingOccurrences(of: "\\(", with: "{").replacingOccurrences(of: ")", with: "}")
    //     return .skipChildren
    // }
}

class ExtractMethodType : ValueVisitor {
    // func visit(_ node: ImplicitMemberExprSyntax) -> SyntaxVisitorContinueKind {
    //     self.value = trim("\(node)").replacingOccurrences(of: ".", with: "")
    //     return .skipChildren
    // }
}

class ExtractAll : ValueVisitor {
    func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
        print(trim("\(node)"))
        return .skipChildren
    }
}



func extractAll(syntax: Syntax) throws -> [Node] {
    var visitor = TokenVisitor()
    syntax.walk(&visitor)

    return visitor.tree
}

// struct TokenVisitor : SyntaxAnyVisitor {
//     mutating func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
//         print(trim("--> \(node)"))

//         var syntax = "\(type(of: node))"


//         return .visitChildren
//     }
// }


class ExtractAny : SyntaxVisitor {
    func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
        print(trim("--> \(node)"))
        return .skipChildren
    }
}
