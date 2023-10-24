import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project(
    name: "PensionKey-iOS",
    organizationName: PensionKeyOrganizationName,
    targets: [
        Target(
            name: "PensionKey-iOS",
            platform: .iOS,
            product: .app,
            bundleId: "\(PensionKeyOrganizationName).iOS",
            deploymentTarget: .iOS(
                targetVersion: "16.0",
                devices: [.iphone, .ipad]
            ),
            infoPlist: .file(path: "SuportingFile/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .Project.appFlow
            ]
        )
    ]
)
