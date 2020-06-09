/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

public extension View {
	/// Sets the style for grids within this view.
	func gridStyle<S>(_ style: S) -> some View where S: GridStyle {
		environment(\.gridStyle, style)
	}
}
