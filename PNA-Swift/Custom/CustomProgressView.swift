//
//  CustomProgressView.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

@IBDesignable
@objcMembers
class ProgressView: UIView {
    private var progressView: UIView = UIView()
    private var maximumTrackImageView: UIImageView = UIImageView()
    private var minimumTrackImageView: UIImageView = UIImageView()
    private var trackImageView: UIImageView = UIImageView()
    private var trackPosition: CGFloat = 0.0
    
    @IBInspectable var value: CGFloat = 0.0
    @IBInspectable var maximum: CGFloat = 1.0
    @IBInspectable var minimum: CGFloat = 0.0
    
    @IBInspectable open var maximumTrackImage: UIImage? {
        didSet {
            maximumTrackImageView.image =  maximumTrackImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    @IBInspectable open var minimumTrackImage: UIImage? {
        didSet {
            minimumTrackImageView.image =  minimumTrackImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    @IBInspectable open var trackImage: UIImage? {
        didSet {
            trackImageView.contentMode = .scaleAspectFit
            trackImageView.image = trackImage
        }
    }
    required override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        
        setupView()
        super.layoutSubviews()
    }
    
    private func setupView() {
        //height of view = 44
        self.backgroundColor = UIColor.clear
        self.frame.size = CGSize(width: self.frame.size.width, height: (minimumTrackImage?.size.height)! + (trackImage?.size.height)!)
        
        progressView.backgroundColor = UIColor.clear
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = (minimumTrackImage?.size.height)!/2
        progressView.frame = CGRect(x: 0, y: self.frame.size.height - (minimumTrackImage?.size.height)!, width: self.frame.size.width, height: (minimumTrackImage?.size.height)!)
        self.addSubview(progressView)
        
        progressView.addSubview(maximumTrackImageView)
        maximumTrackImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: (maximumTrackImage?.size.height)!)
        
        progressView.addSubview(minimumTrackImageView)
        minimumTrackImageView.frame = CGRect(x: 0, y: 0, width: trackPosition, height: (minimumTrackImage?.size.height)!)
        
        self.addSubview(trackImageView)
        trackImageView.frame = CGRect(x:trackPosition-(trackImage?.size.width)!/2, y: self.frame.size.height - (minimumTrackImage?.size.height)! - (trackImage?.size.height)!, width: (trackImage?.size.width)!, height: (trackImage?.size.height)!)
    }
    public func changeValue(_value:CGFloat){
        if _value<=maximum && _value>=minimum{
            value = _value
            let percent: CGFloat = _value*100.0/(maximum - minimum)
            DispatchQueue.main.async {
                self.trackPosition = percent * self.frame.size.width/100.0
            }
        }
        refresh()
    }
    func refresh(){
        DispatchQueue.main.async {
            self.trackImageView.frame = CGRect(x: self.trackPosition - self.trackImageView.frame.size.width/2, y: self.trackImageView.frame.origin.y, width: self.trackImageView.frame.size.width, height: self.trackImageView.frame.size.height)
            self.minimumTrackImageView.frame = CGRect(x: 0, y: 0, width: self.trackPosition, height: (self.minimumTrackImage?.size.height)!)
        }
    }
}
