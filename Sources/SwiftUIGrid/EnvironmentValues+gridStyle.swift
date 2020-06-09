/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

extension EnvironmentValues {
	var gridStyle: GridStyle {
		get {
			self[GridStyleKey.self]
		}
		set {
			self[GridStyleKey.self] = newValue
		}
	}
}
