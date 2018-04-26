//
//  CustomLabel.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
@IBDesignable
@objcMembers
class CustomLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor = Global.BORDER_LABEL_COLOR {
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
extension UILabel {
    var setNewFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
    func resizeToStretch()-> CGFloat{
        self.lineBreakMode = NSLineBreakMode.byWordWrapping;
        self.numberOfLines = 0;
        let constraint = CGSize(width:self.frame.size.width , height: 3000.0)
        if self.attributedText?.length == 0 {
            return 0
        }
        let attributes = self.attributedText?.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, (self.attributedText?.length)!))
        
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let boundingBox = self.text?.boundingRect(with: constraint, options: option, attributes: attributes, context: nil)
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: (boundingBox?.height)!)
        return boundingBox!.height
    }
}
