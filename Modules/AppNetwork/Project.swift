import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "AppNetwork",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.core
    ]
)
