import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "PensionKeyKit",
    resources: ["Resources/**"],
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.core
    ]
)
