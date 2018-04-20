import UIKit
class LibFont: NSObject {
    static let sharedInstance : LibFont = {
        let inst = LibFont()
        return inst
    }()
    func changeFont(_ control: AnyObject) {
        if (control is UILabel) {
            let lbl: UILabel? = (control as? UILabel)
            lbl?.font = UIFont(name: LibFont.sharedInstance.fontName(), size: (lbl?.font.pointSize)!)
            return
        }
        if (control is UIButton) {
            let btn: UIButton? = (control as? UIButton)
            btn?.titleLabel?.font = UIFont(name: LibFont.sharedInstance.fontName(), size: (btn?.titleLabel?.font.pointSize)!)
            return
        }
        if (control is UITextField) {
            let txt: UITextField? = (control as? UITextField)
            txt?.textColor = UIColor(red: CGFloat(198 / 255.0), green: CGFloat(160 / 255.0), blue: CGFloat(64 / 255.0), alpha: CGFloat(1))
            return
        }
        if (control is UITextView) {
            let txt: UITextView? = (control as? UITextView)
            txt?.textColor = UIColor(red: CGFloat(198 / 255.0), green: CGFloat(160 / 255.0), blue: CGFloat(64 / 255.0), alpha: CGFloat(1))
            return
        }
        for ctr: UIControl in control.subviews as! [UIControl] {
            LibFont.sharedInstance.changeFont(ctr)
        }
    }
    func fontName() -> String {
           return "arial"
    }
}
