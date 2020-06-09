/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

extension Array {
	func partitionedIntoSubsequences(ofCapacity subsequenceCapacity: Int) -> Array<ArraySlice<Element>> {
		stride(from: startIndex, to: endIndex, by: subsequenceCapacity)
			.map { index in
				self[index ..< Swift.min(index + subsequenceCapacity, endIndex)]
		}
	}
}
