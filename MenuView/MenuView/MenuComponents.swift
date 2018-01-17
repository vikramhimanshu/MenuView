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

struct Element : RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: String
    
    init(rawValue value: String) {
        self.rawValue = value
    }
}

extension Element: Comparable {
    public static func <(lhs: Element, rhs: Element) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <=(lhs: Element, rhs: Element) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >=(lhs: Element, rhs: Element) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func >(lhs: Element, rhs: Element) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

extension Element: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Element: Equatable {
    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Element: ExpressibleByStringLiteral {
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

struct Category : RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: String
    
    init(rawValue value: String) {
        self.rawValue = value
    }
}

extension Category: Comparable {
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
}

extension Category: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Category: ExpressibleByStringLiteral {
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

protocol Section {
    var items: [Element] { get }
    var category: Category { get }
}

protocol Item {
    var item: Element { get }
    var category: Category { get }
}
