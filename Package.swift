// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SwiftUIGrid",
	
	platforms: [
		.iOS(.v13)
	],
	
	products: [
		.library(name: "SwiftUIGrid", targets: ["SwiftUIGrid"])
	],
	
	targets: [
		.target(name: "SwiftUIGrid", dependencies: []),
		.testTarget(name: "SwiftUIGridTests", dependencies: ["SwiftUIGrid"])
	]
)
