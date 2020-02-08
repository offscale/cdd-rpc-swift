func printModel(model: Model) -> String {
    // structCodeBlock(name: model.name, type: "nope", members: [
    //     variableDecl(variableName: "a", variableType: "Int")
    // ]).description

    print(model);

    return structCodeBlock(name: model.name, type: "nope", members: model.vars.map({ variable in
        return variableDecl(variableName: variable.name, variableType: variable.type.toString())
    })).description
}