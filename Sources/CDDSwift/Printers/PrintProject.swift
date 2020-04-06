func printProject(_ project: Project) -> String {
    return project.models.map({ printModel(model: $0) }).joined(separator: "\n\n")
}