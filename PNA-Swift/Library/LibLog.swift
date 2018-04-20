import Foundation
public class LibLog: NSObject{
    class func log(_ object: Any, message strMessage: Any) {
        print("\(String(describing: type(of: object))) \(strMessage)")
    }
    class func log(_ object: Any, caption strCaption: String, message strMessage: Any) {
        print("\(String(describing: type(of: object))) \(strCaption) \(strMessage)")
    }
}
