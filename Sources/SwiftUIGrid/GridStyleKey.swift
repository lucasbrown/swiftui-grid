/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

struct GridStyleKey: EnvironmentKey {
	static var defaultValue: GridStyle = VerticalGridStyle(itemsPerRow: 3)
}
