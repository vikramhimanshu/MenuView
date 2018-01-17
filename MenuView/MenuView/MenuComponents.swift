//
//  MenuComponents.swift
//  MenuView
//
//  Created by Himanshu Tantia on 16/1/18.
//  Copyright © 2018 Kreativ Apps, LLC. All rights reserved.
//

import Foundation

protocol Displayable {
    var title: String? { get }
}

struct Item : RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: String
    
    init(rawValue value: String) {
        self.rawValue = value
    }
}

extension Item: Comparable {
    public static func <(lhs: Item, rhs: Item) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <=(lhs: Item, rhs: Item) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >=(lhs: Item, rhs: Item) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func >(lhs: Item, rhs: Item) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

extension Item: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Item: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.rawValue = value
    }
    init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

struct Category : RawRepresentable, Equatable, Hashable, Comparable  {
    var rawValue: String
    
    init(rawValue value: String) {
        self.rawValue = value
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func <(lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <=(lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >=(lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func >(lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

protocol Section {
    var items: [Item] { get }
    var category: Category { get }
}

protocol MenuItem {
    var item: Item { get }
    var category: Category { get }
}

struct MenuSection : Section {
    var items: [Item]
    var category: Category
}

struct MainMenuItem : MenuItem {
    var item: Item
    var category: Category
}
