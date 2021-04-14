//
//  SupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct SupplementaryItem: LayoutSupplementaryItem, ResizableItem, HasResizableProperties {

    public enum AnchorOffset {
        case absolute(CGPoint)
        case fractional(CGPoint)
    }

    public var widthDimension: NSCollectionLayoutDimension
    public var heightDimension: NSCollectionLayoutDimension
    private var elementKind: String

    private var containerAnchor = NSCollectionLayoutAnchor(edges: [.top, .leading])
    private var itemAnchor: NSCollectionLayoutAnchor?

    // MARK: - Life cycle

    public init(widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1),
                elementKind: String) {
        self.widthDimension = widthDimension
        self.heightDimension = heightDimension
        self.elementKind = elementKind
    }

    public init(size: NSCollectionLayoutSize,
                elementKind: String) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.elementKind = elementKind
    }

    // MARK: - SupplementaryItem

    public func containerAnchor(_ containerAnchor: NSCollectionLayoutAnchor) -> Self {
        with(self) { $0.containerAnchor = containerAnchor }
    }

    public func containerAnchor(edges: NSDirectionalRectEdge) -> Self {
        containerAnchor(NSCollectionLayoutAnchor(edges: edges))
    }

    public func containerAnchor(edges: NSDirectionalRectEdge, offset: AnchorOffset) -> Self {
        switch offset {
        case let .absolute(point):
            return containerAnchor(NSCollectionLayoutAnchor(edges: edges, absoluteOffset: point))
        case let .fractional(point):
            return containerAnchor(NSCollectionLayoutAnchor(edges: edges, fractionalOffset: point))
        }
    }

    public func itemAnchor(_ itemAnchor: NSCollectionLayoutAnchor?) -> Self {
        with(self) { $0.itemAnchor = itemAnchor }
    }

    public func itemAnchor(edges: NSDirectionalRectEdge) -> Self {
        itemAnchor(NSCollectionLayoutAnchor(edges: edges))
    }

    public func itemAnchor(edges: NSDirectionalRectEdge, offset: AnchorOffset) -> Self {
        switch offset {
        case let .absolute(point):
            return itemAnchor(NSCollectionLayoutAnchor(edges: edges, absoluteOffset: point))
        case let .fractional(point):
            return itemAnchor(NSCollectionLayoutAnchor(edges: edges, fractionalOffset: point))
        }
    }

    // MARK: - LayoutSupplementaryItem

    public var layoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        if let itemAnchor = itemAnchor {
            return NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor,
                itemAnchor: itemAnchor
            )
        } else {
            return NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor
            )
        }
    }
}

public extension SupplementaryItem.AnchorOffset {
    static func absolute(x: CGFloat, y: CGFloat) -> SupplementaryItem.AnchorOffset {
        return .absolute(CGPoint(x: x, y: y))
    }

    static func fractional(x: CGFloat, y: CGFloat) -> SupplementaryItem.AnchorOffset {
        return .fractional(CGPoint(x: x, y: y))
    }
}
