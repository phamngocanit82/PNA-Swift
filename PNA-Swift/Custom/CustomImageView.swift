//
//  CustomImageView.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView
@IBDesignable
@objcMembers
class CustomImageView: UIImageView {
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = Global.BORDER_IMAGEVIEW_COLOR {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
extension UIImageView {
    func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
    func setImageURL(_ url: String) {
        addAnimation(self)
        let sdDownloader = SDWebImageDownloader.shared()
        sdDownloader.username = Global.AUTH_USERNAME
        sdDownloader.password = Global.AUTH_PASS
        let encodeUrl: String! = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        self.sd_setImage(with: NSURL(string: encodeUrl)! as URL, placeholderImage: UIImage(named: Global.DEFAULT_LOAD_IMAGE), options: .refreshCached, progress: {receivedSize, expectedSize, targetURL in
        }, completed: { image, error, cacheType, imageURL in
            self.removeAnimation(self)
        })
    }
    func addAnimation(_ object: NSObject) {
        let imageView = object as? UIImageView
        let contentView = imageView?.viewWithTag(50)
        if contentView == nil {
            if ((imageView?.frame.size.width)! <= CGFloat(70) && (imageView?.frame.size.height)! <= CGFloat(70)) {
                let contentView = UIView(frame: CGRect(x: 0, y: 0, width: (imageView?.frame.size.width)!, height: (imageView?.frame.size.height)!))
                contentView.tag = 50
                contentView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                let animationView = UIView(frame: CGRect(x: contentView.frame.size.width/7, y: contentView.frame.size.height/7, width: contentView.frame.size.width-2*contentView.frame.size.width/7, height: contentView.frame.size.height-2*contentView.frame.size.height/7))
                animationView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                animationView.tag = 51
                
                let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (animationView.frame.size.width - 8) / 2, y: 8, width: 8, height: 8), type: NVActivityIndicatorType.ballSpinFadeLoader, color: Global.LOAD_IMAGE_ACTIVITY_INDICATOR_COLOR)
                activityIndicatorView.tag = 52
                activityIndicatorView.padding = 14
                
                animationView.addSubview(activityIndicatorView)
                activityIndicatorView.startAnimating()
                let loadingLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 18, width:animationView.frame.size.width, height: 15))
                loadingLabel.tag = 53
                loadingLabel.text = "Picture is loading..."
                loadingLabel.textAlignment = .center
                loadingLabel.textColor = UIColor.black
                loadingLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 4)
                animationView.addSubview(loadingLabel)
                
                let pleaseWaitLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 8, width: animationView.frame.size.width, height: 15))
                pleaseWaitLabel.tag = 54
                pleaseWaitLabel.text = "Please wait"
                pleaseWaitLabel.textAlignment = .center
                pleaseWaitLabel.textColor = UIColor.black
                pleaseWaitLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 4)
                animationView.addSubview(pleaseWaitLabel)
                contentView.addSubview(animationView)
                imageView?.addSubview(contentView)
            }else{
                if ((imageView?.frame.size.width)! <= CGFloat(100) && (imageView?.frame.size.height)! <= CGFloat(100)){
                    let contentView = UIView(frame: CGRect(x: 0, y: 0, width: (imageView?.frame.size.width)!, height: (imageView?.frame.size.height)!))
                    contentView.tag = 50
                    contentView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                    let animationView = UIView(frame: CGRect(x: contentView.frame.size.width/10, y: contentView.frame.size.height/7, width: contentView.frame.size.width-2*contentView.frame.size.width/10, height: contentView.frame.size.height-2*contentView.frame.size.height/7))
                    animationView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                    animationView.tag = 51
                    
                    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (animationView.frame.size.width - 10) / 2, y: 10, width: 10, height: 10), type: NVActivityIndicatorType.ballSpinFadeLoader, color: Global.LOAD_IMAGE_ACTIVITY_INDICATOR_COLOR)
                    activityIndicatorView.tag = 52
                    activityIndicatorView.padding = 16
                    
                    animationView.addSubview(activityIndicatorView)
                    activityIndicatorView.startAnimating()
                    let loadingLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 30, width:animationView.frame.size.width, height: 15))
                    loadingLabel.tag = 53
                    loadingLabel.text = "Picture is loading..."
                    loadingLabel.textAlignment = .center
                    loadingLabel.textColor = UIColor.black
                    loadingLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 7)
                    animationView.addSubview(loadingLabel)
                    
                    let pleaseWaitLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 15, width: animationView.frame.size.width, height: 15))
                    pleaseWaitLabel.tag = 54
                    pleaseWaitLabel.text = "Please wait"
                    pleaseWaitLabel.textAlignment = .center
                    pleaseWaitLabel.textColor = UIColor.black
                    pleaseWaitLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 7)
                    animationView.addSubview(pleaseWaitLabel)
                    contentView.addSubview(animationView)
                    imageView?.addSubview(contentView)
                }else{
                    let contentView = UIView(frame: CGRect(x: 0, y: 0, width: (imageView?.frame.size.width)!, height: (imageView?.frame.size.height)!))
                    contentView.tag = 50
                    contentView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                    let animationView = UIView(frame: CGRect(x: contentView.frame.size.width/7, y: contentView.frame.size.height/7, width: contentView.frame.size.width-2*contentView.frame.size.width/7, height: contentView.frame.size.height-2*contentView.frame.size.height/7))
                    animationView.backgroundColor = Global.LOAD_IMAGE_BACKGROUND_COLOR
                    animationView.tag = 51
                    
                    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (animationView.frame.size.width - 15) / 2, y: animationView.frame.height/6, width: 15, height: 15), type: NVActivityIndicatorType.ballSpinFadeLoader, color: Global.LOAD_IMAGE_ACTIVITY_INDICATOR_COLOR)
                    activityIndicatorView.tag = 52
                    activityIndicatorView.padding = 24
                    
                    animationView.addSubview(activityIndicatorView)
                    activityIndicatorView.startAnimating()
                    let loadingLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.height/6 + 40, width:animationView.frame.size.width, height: 15))
                    loadingLabel.tag = 53
                    loadingLabel.text = "Picture is loading..."
                    loadingLabel.textAlignment = .center
                    loadingLabel.textColor = UIColor.black
                    loadingLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 10)
                    animationView.addSubview(loadingLabel)
                    
                    let pleaseWaitLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.height/6 + 60, width: animationView.frame.size.width, height: 15))
                    pleaseWaitLabel.tag = 54
                    pleaseWaitLabel.text = "Please wait"
                    pleaseWaitLabel.textAlignment = .center
                    pleaseWaitLabel.textColor = UIColor.black
                    pleaseWaitLabel.font = UIFont (name: Global.FONT_NAME_NORMAL, size: 10)
                    animationView.addSubview(pleaseWaitLabel)
                    contentView.addSubview(animationView)
                    imageView?.addSubview(contentView)
                }
            }
        }
    }
    func removeAnimation(_ object: NSObject) {
        let imageView = object as? UIImageView
        var contentView = imageView?.viewWithTag(50)
        if contentView != nil {
            let animationView = contentView?.viewWithTag(51)
            var activityIndicatorView = animationView?.viewWithTag(52) as? NVActivityIndicatorView
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
            contentView?.removeFromSuperview()
            contentView = nil
        }
    }
}
