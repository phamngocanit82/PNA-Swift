import UIKit
import Foundation
import SDWebImage
import NVActivityIndicatorView
class LibImage: NSObject{
    class func imageWithPath(_ object: NSObject, strPath: String){
        var className: String = String(describing: type(of: object))
        className = className.replacingOccurrences(of: "MILImageView", with: "UIImageView")
        className = className.replacingOccurrences(of: "MILButton", with: "UIButton")
        let array = ["UIImageView", "UIButton"]
        let index: Int = (array as NSArray).index(of: className)
        switch index {
            case 0:
                let imageView = object as? UIImageView
                addAnimation(imageView!)
                imageView?.sd_setImage(with: NSURL(string: strPath)! as URL, placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, progress: { receivedSize, expectedSize in
                }, completed: { image, error, cacheType, imageURL in
                    removeAnimation(imageView!)
                })
                break
            case 1:
                let button = object as? UIButton
                button?.sd_setImage(with: NSURL(string: strPath)! as URL, for:.normal , placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { image, error, cacheType, imageURL in
                    //
                })
                break
        default:
            break
        }
    }
    class func addAnimation(_ object: NSObject) {
        let imageView = object as? UIImageView
        let contentView = imageView?.viewWithTag(50)
        if contentView == nil {
            if ((imageView?.frame.size.width)! <= CGFloat(70) && (imageView?.frame.size.height)! <= CGFloat(70)) {
                let contentView = UIView(frame: CGRect(x: 0, y: 0, width: (imageView?.frame.size.width)!, height: (imageView?.frame.size.height)!))
                contentView.tag = 50
                contentView.backgroundColor = UIColor.white
                let animationView = UIView(frame: CGRect(x: (contentView.frame.size.width - 54) / 2, y: (contentView.frame.size.height - 60) / 2, width: 54, height: 54))
                animationView.backgroundColor = UIColor.white
                animationView.tag = 51
                
                let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (animationView.frame.size.width - 10) / 2, y: 10, width: 10, height: 10), type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor(red: 0, green: 157 / 255.0, blue: 48 / 255.0, alpha: 1))
                activityIndicatorView.tag = 52
                activityIndicatorView.padding = 16
                
                animationView.addSubview(activityIndicatorView)
                activityIndicatorView.startAnimating()
                let loadingLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 30, width:animationView.frame.size.width, height: 15))
                loadingLabel.tag = 53
                loadingLabel.text = "Picture is loading..."
                loadingLabel.textAlignment = .center
                loadingLabel.textColor = UIColor.black
                loadingLabel.font = UIFont.systemFont(ofSize: 7)
                animationView.addSubview(loadingLabel)
                
                let pleaseWaitLabel = UILabel(frame: CGRect(x: 0, y: animationView.frame.size.height - 15, width: animationView.frame.size.width, height: 15))
                pleaseWaitLabel.tag = 54
                pleaseWaitLabel.text = "Please wait"
                pleaseWaitLabel.textAlignment = .center
                pleaseWaitLabel.textColor = UIColor.black
                pleaseWaitLabel.font = UIFont.systemFont(ofSize: 7)
                animationView.addSubview(pleaseWaitLabel)
                contentView.addSubview(animationView)
                imageView?.addSubview(contentView)
            }
        }
    }
    class func removeAnimation(_ object: NSObject) {
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
    class func encode(_ string: String) -> String {
        let newString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (string as? CFString), nil, ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`" as CFString, CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as String?
        return newString!
    }

}
