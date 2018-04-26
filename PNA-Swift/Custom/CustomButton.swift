//
//  CustomButton.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
@IBDesignable
@objcMembers
class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor = Global.BORDER_BUTTON_COLOR {
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
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
extension UIButton {
    var setNewFontName : String {
        get { return (self.titleLabel?.font.fontName)! }
        set { self.titleLabel?.font = UIFont(name: newValue, size: (self.titleLabel?.font.pointSize)!) }
    }
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
