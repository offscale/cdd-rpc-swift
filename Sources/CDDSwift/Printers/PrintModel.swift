func printModel(model: Model) -> String {
    return structCodeBlock(name: model.name, type: "APIModel", members: model.vars.map({ variable in
        return variableDecl(variableName: variable.name, variableType: variable.type.toString())
    })).description
}