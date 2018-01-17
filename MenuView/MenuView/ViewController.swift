//
//  ViewController.swift
//  MenuView
//
//  Created by Himanshu Tantia on 16/1/18.
//  Copyright © 2018 Kreativ Apps, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var menu: MenuView?
    
    
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
        
        let i = UserMenuItem.one.rawValue
        let i1 = UserMenuItem.two.rawValue
        let i2 = UserMenuItem.two.rawValue
        let i3 = UserMenuItem.two.rawValue
        let i4 = UserMenuItem.two.rawValue
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
        let i = UserMenuItem.one
        let sec = MenuSection(items: [i.rawValue], category: .some)
        return [sec]
    }
    
    func menuView(_ menuView: Menu, viewForItemAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}

extension ViewController : MenuDelegate {
    func menuView(_ menuView: Menu, didSelectItem item: MenuItem, at indexPath: IndexPath) {
        
    }
}

enum UserMenuItem : Item {
    typealias RawValue = Item
    case one, two , three, four, five, six, seven, eight
}

extension Category {
    static let some = Category(rawValue: "some category")
}
