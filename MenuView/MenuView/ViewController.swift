//
//  ViewController.swift
//  MenuView
//
//  Created by Himanshu Tantia on 16/1/18.
//  Copyright © 2018 Kreativ Apps, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var menu: Menu?
    
    struct MenuSection : Section {
        var items: [Element]
        var category: Category
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width * 2/3
        let displayHeight: CGFloat = self.view.frame.height
        let frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let v = MenuView(withFrame: frame, andPresentingView: self.view)
        v.datasource = self
        v.delegate = self
        self.view.addSubview(v)
        
        let i = Element.one
        let i1 = Element.two
        let i2 = Element.two
        let i3 = Element.two
        let i4 = Element.two
        let sec = MenuSection(items: [i, i1,i2,i3,i4], category: .some)
        v.setSections([sec])
        menu = v
    }
    
    @IBAction func menuPressed(_ sender: UIBarButtonItem) {
        menu?.toggle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : MenuDataSource {
    func sections(in menuView: Menu) -> [Section] {
        let sec = MenuSection(items: [.one], category: .some)
        return [sec]
    }
    
    func menuView(_ menuView: Menu, viewForItemAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}

extension ViewController : MenuDelegate {
    func menuView(_ menuView: Menu, didSelectItem item: Item, at indexPath: IndexPath) {
        
    }
}

extension Element {
    static let one = Element(rawValue: "one")
    static let two = Element(rawValue: "two")
    static let three = Element(rawValue: "three")
    static let four = Element(rawValue: "four")
    static let five = Element(rawValue: "five")
}

extension Element : Displayable {
    var title: String? {
        switch self {
        case .one:
            return "First Menu Item"
        case .two:
            return "Second Menu Item"
        default:
            return "Default Menu Item"
        }
    }
}

extension Category {
    static let some = Category(rawValue: "some category")
}
extension Category : Displayable {
    var title: String? {
        switch self {
        case .some:
            return "Default"
        default:
            return nil
        }
    }
}
