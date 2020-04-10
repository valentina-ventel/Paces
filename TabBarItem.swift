//
//  File.swift
//  Paces
//
//  Created by Valentina Vențel on 10/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import UIKit

class knTabBarItem: UIButton {
    var itemHeight: CGFloat = 0
    var lock = false
    var color: UIColor = UIColor.lightGray {
        didSet {
            guard lock == false else { return }
            iconImageView.image = iconImageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconImageView.tintColor = color
            textLabel.textColor = color
        }}
    
    private let iconImageView = knUIMaker.makeImageView(contentMode: .scaleAspectFit)
    private let textLabel = knUIMaker.makeLabel(font: UIFont.systemFont(ofSize: 11),
                                        color: .black, alignment: .center)
    
    convenience init(icon: UIImage, title: String,
                     font: UIFont = UIFont.systemFont(ofSize: 18)) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = icon
        textLabel.text = title
        textLabel.font = UIFont(name: font.fontName, size: 11)
        setupView()
    }
    
    private func setupView() {
        addSubviews(views: iconImageView, textLabel)
        iconImageView.top(toView: self, space: 4)
        iconImageView.centerX(toView: self)
        iconImageView.square()
        
        let iconBottomConstant: CGFloat = textLabel.text == "" ? -2 : -20
        iconImageView.bottom(toView: self, space: iconBottomConstant)
        
        textLabel.bottom(toView: self, space: -2)
        textLabel.centerX(toView: self)
    }
}
