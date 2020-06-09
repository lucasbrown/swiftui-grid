/**
* SwiftUIGrid
* Copyright © 2020 Lucas Brown
*/

import SwiftUI

/// An object that presents an ordered collection of data items in a grid layout.
public struct Grid<Data, ItemContent>: View where Data: RandomAccessCollection, Data.Element: Hashable, ItemContent: View {
	public init(_ data: Data, @ViewBuilder itemContent: @escaping (Data.Element) -> ItemContent) {
		self.data = Array(data)
		self.itemContent = itemContent
	}
	
	public var body: some View {
		ScrollView(style.scrollDirection == Axis.horizontal ? Axis.Set.horizontal : Axis.Set.vertical, showsIndicators: style.showsScrollIndicators) {
			GeometryReader { geometryProxy in
				self.makeStackContainingStack {
					ForEach(self.partitionedData, id: \.self) { subsequence in
						self.makeItemContainingStack {
							ForEach(subsequence, id: \.self) { element in
								self.itemContent(element)
									.frame(width: self.itemSize?.width, height: self.itemSize?.height)
							}
						}
					}
				}
				.preference(key: ContainerSizeKey.self, value: geometryProxy.size)
			}
			.onPreferenceChange(ContainerSizeKey.self) { value in
				self.containerSize = value
			}
			.frame(width: gridSize?.width, height: gridSize?.height)
			.padding(style.inset)
		}
	}
	
	@Environment(\.gridStyle) private var style
	@State private var containerSize: CGSize?
	private let data: Array<Data.Element>
	private let itemContent: (Data.Element) -> ItemContent
}

// MARK: - private extension Grid

private extension Grid {
	struct ContainerSizeKey: PreferenceKey {
		static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
			value = nextValue()
		}
	}
	
	/// The size of the grid, defined by its container's size and item size.
	var gridSize: CGSize? {
		guard let containerSize = containerSize, let itemSize = itemSize else {
			return nil
		}
		
		let numberOfLines = CGFloat(partitionedData.count)
		let totalLineSpacing = (numberOfLines - 1) * style.lineSpacing
		
		switch style.scrollDirection {
			case .horizontal:
				return CGSize(width: (numberOfLines * itemSize.height) + totalLineSpacing, height: containerSize.height)
			case .vertical:
				return CGSize(width: containerSize.width, height: (numberOfLines * itemSize.width) + totalLineSpacing)
		}
	}
	
	/// The spacing to use between items in the same line.
	var interitemSpacing: CGFloat? {
		guard let containerSize = containerSize, let itemSize = itemSize else {
			return nil
		}
		
		let automaticInteritemSpacing: CGFloat
		let itemsPerLine = CGFloat(style.itemsPerLine)
		
		switch style.scrollDirection {
			case .horizontal:
				automaticInteritemSpacing = (containerSize.height - (itemSize.height * itemsPerLine)) / (itemsPerLine - 1)
			case .vertical:
				automaticInteritemSpacing = (containerSize.width - (itemSize.width * itemsPerLine)) / (itemsPerLine - 1)
		}
		
		return automaticInteritemSpacing > style.minimumInteritemSpacing ? automaticInteritemSpacing : style.minimumInteritemSpacing
	}
	
	/// The size to use for items.
	var itemSize: CGSize? {
		guard let containerSize = containerSize else {
			return nil
		}
		
		let itemsPerLine = CGFloat(style.itemsPerLine)
		let totalMinimumInteritemSpacing = (itemsPerLine - 1) * style.minimumInteritemSpacing
		
		switch style.scrollDirection {
			case .horizontal:
				let automaticItemHeight = (containerSize.height - totalMinimumInteritemSpacing) / itemsPerLine
				
				return style.itemSize(automaticItemSize: CGSize(width: automaticItemHeight, height: automaticItemHeight))
			case .vertical:
				let automaticItemWidth = (containerSize.width - totalMinimumInteritemSpacing) / itemsPerLine
				
				return style.itemSize(automaticItemSize: CGSize(width: automaticItemWidth, height: automaticItemWidth))
		}
	}
	
	/// Data formatted for the grid, dependent on the grid style.
	var partitionedData: Array<ArraySlice<Data.Element>> {
		data.partitionedIntoSubsequences(ofCapacity: style.itemsPerLine)
	}
	
	/// Makes a stack-containing stack, dependent on the grid style.
	func makeStackContainingStack<Content>(@ViewBuilder content: () -> Content) -> some View where Content: View {
		Group {
			if style.scrollDirection == .horizontal {
				HStack(alignment: .top, spacing: style.lineSpacing, content: content)
			} else if style.scrollDirection == .vertical {
				VStack(alignment: .leading, spacing: style.lineSpacing, content: content)
			}
		}
	}
	
	/// Makes an item-containing stack, dependent on the grid style.
	func makeItemContainingStack<Content>(@ViewBuilder content: () -> Content) -> some View where Content: View {
		Group {
			if style.scrollDirection == .horizontal {
				VStack(spacing: interitemSpacing, content: content)
			} else if style.scrollDirection == .vertical {
				HStack(spacing: interitemSpacing, content: content)
			}
		}
	}
}
