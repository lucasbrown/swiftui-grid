/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

/// A grid style that lays out items on a vertical axis.
///
/// To apply this style to a grid, or to a view that contains grids, use the `gridStyle(_:)` modifier.
public struct VerticalGridStyle: GridStyle {
	public let scrollDirection: Axis = .vertical
	public let itemsPerLine: Int
	public let inset: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
	public let lineSpacing: CGFloat = 8
	public let minimumInteritemSpacing: CGFloat = 8
	public let showsScrollIndicators: Bool
	
	public init(itemsPerRow: Int, showsScrollIndicators: Bool = true) {
		itemsPerLine = itemsPerRow
		self.showsScrollIndicators = showsScrollIndicators
	}
}
