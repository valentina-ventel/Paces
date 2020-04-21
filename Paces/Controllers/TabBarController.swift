//
//  TabBarController.swift
//  Paces
//
//  Created by Valentina Vențel on 11/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import UIKit

enum tabBarItemName: String {
    case Map
    case Me
    case Social
    case Steps
    case New
    
    func nameTabBarItem() -> String {
        return self.rawValue
    }
}
class MyTabBarCtrl: UITabBarController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
    }
    
    func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
    
    
   func setupMiddleButton() {
        guard var tabItems = self.tabBar.items else { return }
        
        tabItems[0].titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 0)
        tabItems[1].titlePositionAdjustment = UIOffset(horizontal: -30, vertical: 0)
        tabItems[2].titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0)
        tabItems[3].titlePositionAdjustment = UIOffset(horizontal: 15, vertical: 0)

        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 35, y: -25, width: 70, height: 70))
           
           //STYLE THE BUTTON YOUR OWN WAY
        middleBtn.setImage(UIImage(named: "RunnerIcon"), for: .normal)
        middleBtn.layer.borderColor = UIColor.systemGray3.cgColor
        
        middleBtn.layer.borderWidth = 7
    
        middleBtn.backgroundColor = .systemGreen
        middleBtn.applyRoundCorner()
           
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

       // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Activity") as ActivityViewController
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
}
