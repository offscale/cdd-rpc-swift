

func update(project: Project, code: String) -> String {
    if code == "" {
        return printProject(project)
    }
    return code
}

func parse(code: String) throws -> Project {
    // if code == "" {
    //     return printProject(project)
    // }
    return try parseProject(code)
}
