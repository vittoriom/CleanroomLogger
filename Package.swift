import PackageDescription

let package = Package(
	name: "CleanroomLogger",
	dependencies: [
		.Package(url: "https://github.com/emaloney/CleanroomASL", versions: Version(1,3,7) ..< Version(2,0,0))
	]
)
