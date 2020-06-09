/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

/// A type that specifies the appearance and interaction of all grids within a view hierarchy.
public protocol GridStyle {
	/// The scroll direction of the grid.
	var scrollDirection: Axis { get }
	/// The maximum number of items in each line.
	var itemsPerLine: Int { get }
	/// The margins used to lay out the grid.
	var inset: EdgeInsets { get }
	/// The spacing to use between lines of items in the grid.
	var lineSpacing: CGFloat { get }
	/// The minimum spacing to use between items in the same line.
	var minimumInteritemSpacing: CGFloat { get }
	/// A Boolean value that indicates whether the scroll view displays the scrollable component of the content offset, in a way suitable for the platform.
	var showsScrollIndicators: Bool { get }
	/// The size to use for items.
	func itemSize(automaticItemSize: CGSize) -> CGSize
}

public extension GridStyle {
	func itemSize(automaticItemSize: CGSize) -> CGSize {
		automaticItemSize
	}
}
