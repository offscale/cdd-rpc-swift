

func update(project: Project, code: String) -> String {
    if code == "" {
        return printProject(project)
    }
    return code
}

func parse(code: String) -> Project {
    // if code == "" {
    //     return printProject(project)
    // }
    return Project(models: [])
}
