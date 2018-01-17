//
//  MenuView.swift
//  MenuView
//
//  Created by Himanshu Tantia on 16/1/18.
//  Copyright © 2018 Kreativ Apps, LLC. All rights reserved.
//

import UIKit

protocol MenuDelegate : class {
    func menuView(_ menuView: Menu, didSelectItem item: MenuItem, at indexPath: IndexPath)
}

protocol MenuDataSource : class {
    func sections(in menuView: Menu) -> [Section]
    func menuView(_ menuView: Menu, viewForItemAt indexPath: IndexPath) -> UITableViewCell?
}

protocol Menu : class {
    init(withFrame frame: CGRect, andPresentingView presentingView: UIView)
    weak var delegate : MenuDelegate? {get set}
    weak var datasource : MenuDataSource? {get set}
    func setSections(_ sections: [Section])
    func refresh()
    func show(animated: Bool)
    func hide(animated: Bool)
    func toggle()
}

class MenuView: UIView, Menu {
    
    enum State {
        case visible, hidden
        
        mutating func toggle() {
            switch self {
            case .hidden:
                self = .visible
            case .visible:
                self = .hidden
            }
        }
    }
    
    weak var presentingView: UIView?
    weak var delegate: MenuDelegate?
    weak var datasource: MenuDataSource?
    var state: State = .hidden
    
    private var originalFrame: CGRect
    
    private override init(frame: CGRect) {
        originalFrame = frame
        super.init(frame: frame)
        addTableView(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        originalFrame = CGRect.zero
        super.init(coder: aDecoder)
        originalFrame = frame
        addTableView(frame: self.frame)
    }
    
    required init(withFrame frame: CGRect, andPresentingView presentingView: UIView) {
        originalFrame = frame
        super.init(frame: frame)
        self.presentingView = presentingView
        addTableView(frame: frame)
        hide(animated: false)
    }
    
    deinit {
        self.removeFromSuperview()
    }
    
    private func addTableView(frame: CGRect) {
        let _table = UITableView(frame: frame, style: .plain)
        _table.delegate = self
        _table.dataSource = self
        _table.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        _table.rowHeight = UITableViewAutomaticDimension
        _table.tableFooterView = UIView()
        tableView = _table
        self.addSubview(_table)
    }
    
    func hide(animated: Bool = true) {
        guard let presentingView = self.presentingView else { return }
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0.1,
                           options: [.curveEaseIn],
                           animations: {
                            self.center.x -= presentingView.bounds.width
            },
                           completion: nil
            )
        } else {
            self.center.x -= presentingView.bounds.width
        }
    }
    
    func show(animated: Bool = true) {
        guard let presentingView = self.presentingView else { return }
        if self.isDescendant(of: presentingView) == false {
            presentingView.addSubview(self)
        }
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0.1,
                           options: [.curveEaseOut],
                           animations: {
                            self.center.x += presentingView.bounds.width
            },
                           completion: nil
            )
        } else {
            self.center.x += presentingView.bounds.width
        }
    }
    
    func toggle() {
        switch state {
        case .hidden:
            show(animated: true)
        case .visible:
            hide(animated: true)
        }
        state.toggle()
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    func setSections(_ sections: [Section]) {
        self.sections = sections
    }

    @IBOutlet private var tableView : UITableView!
    
    private var sections = [Section]() {
        didSet (oldVal) {
            tableView.reloadData()
        }
    }
}

private typealias MenuTableViewDelegate = MenuView
private typealias MenuTableViewDatasource = MenuView

extension MenuTableViewDelegate : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _menuitem = menuItem(forIndexPath: indexPath)
        delegate?.menuView(self, didSelectItem: _menuitem, at: indexPath)
    }
}

private extension MenuView {
    private func numberOfRowsInSection(section: Int) -> Int {
        return sections[section].items.count
    }
    
    private func numberOfSections() -> Int {
        return sections.count
    }
    
    private func item(atIndexPath indexPath: IndexPath) -> Item {
        let section = sections[indexPath.section]
        let _item = section.items[indexPath.row]
        return _item
    }
    private func section(atIndexPath indexPath: IndexPath) -> Section {
        let section = sections[indexPath.section]
        return section
    }
    private func menuItem(forIndexPath indexPath: IndexPath) -> MenuItem {
        let menuSection = sections[indexPath.section]
        let item = menuSection.items[indexPath.row]
        let mi = MainMenuItem(item: item, category: menuSection.category)
        return mi
    }
}

extension MenuTableViewDatasource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = datasource?.menuView(self, viewForItemAt: indexPath) {
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            let _item = item(atIndexPath: indexPath)
            if let _ditem = _item as? Displayable {
                cell.textLabel?.text = _ditem.title
            } else {
                cell.textLabel?.text = _item.rawValue
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
}
