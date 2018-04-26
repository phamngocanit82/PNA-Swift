//
//  CustomView.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
@IBDesignable
@objcMembers
class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor = Global.BORDER_VIEW_COLOR {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
        
    }
    func setupView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
