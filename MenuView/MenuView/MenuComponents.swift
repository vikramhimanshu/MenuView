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
    var icon: String? { get }
}

protocol Element {
}

protocol Category {
}

protocol DisplayableElement : Element, Displayable {
}

protocol DisplayableCategory : Category, Displayable {
}

protocol Section {
    var items: [Element] { get }
    var category: Category { get }
}

protocol Item {
    var item: Element { get }
    var category: Category { get }
}

protocol MenuItem :class {
    var item: Item { get }
    var children: [Self] { get }
    weak var parent: Self? { get }
}
