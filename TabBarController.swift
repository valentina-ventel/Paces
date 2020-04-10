//
//  TabBarController.swift
//  Paces
//
//  Created by Valentina Vențel on 10/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import UIKit

class knTabController: UITabBarController {
    var kn_tabBar: knTabBar!
    var selectedColor = UIColor.darkGray
    var normalColor = UIColor.lightGray {
        didSet {
            kn_tabBar.tintColor = normalColor
        }}
    
    private var kn_tabBarHeight: CGFloat = 49
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }

    func setupView() {}
    
    func setTabBar(items: [knTabBarItem], height: CGFloat = 49) {
        guard items.count > 0 else { return }
        
        kn_tabBar = knTabBar(items: items)
        guard let bar = kn_tabBar else { return }
        kn_tabBar.tintColor = normalColor
        bar.kn_items.first?.color = selectedColor
        
        view.addSubviews(views: bar)
        bar.horizontal(toView: view)
        bar.bottom(toView: view)
        kn_tabBarHeight = height
        bar.height(kn_tabBarHeight)
        for i in 0 ..< items.count {
            items[i].tag = i
            items[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
    }
    
//    @objc func switchTab(button: UIButton) {
//        let newIndex = button.tag
//        changeTab(from: selectedIndex, to: newIndex)
//    }
    
//    private func changeTab(from fromIndex: Int, to toIndex: Int) {
//        kn_tabBar.kn_items[fromIndex].color = normalColor
//        kn_tabBar.kn_items[toIndex].color = selectedColor
//        animateSliding(from: fromIndex, to: toIndex)
//    }
}
