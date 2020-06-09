/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

/** To-Do
* Add tests for grid math.
	* `gridSize`
	* `interitemSpacing`
	* `itemSize`
* Move view tests to package.
	* Label tests.
*/

import XCTest
@testable import SwiftUIGrid

final class SwiftUIGridTests: XCTestCase {
	func testPartitionedIntoSubsequences() {
		let data = [1, 2]
		let partitionedData = data.partitionedIntoSubsequences(ofCapacity: 1)
		
		XCTAssertEqual(partitionedData, [[1], [2]])
	}
}
