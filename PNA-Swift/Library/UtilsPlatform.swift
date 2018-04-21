import UIKit
class UtilsPlatform: NSObject {
    static let sharedInstance : UtilsPlatform = {
        let inst = UtilsPlatform()
        return inst
    }()
    func platformModelString() -> String? {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString: machine)
        }
        return nil
    }
    func platformString() -> String {
        let platform : String = platformModelString()!
        if platform == "iPhone1,1"    { return "iPhone 1G" }
        if platform == "iPhone1,2"    { return "iPhone 3G" }
        if platform == "iPhone2,1"    { return "iPhone 3GS" }
        if platform == "iPhone3,1"    { return "iPhone 4 (GSM)" }
        if platform == "iPhone3,3"    { return "iPhone 4 (CDMA)" }
        if platform == "iPhone4,1"    { return "iPhone 4S" }
        if platform == "iPhone5,1"    { return "iPhone 5 (GSM)" }
        if platform == "iPhone5,2"    { return "iPhone 5 (GSM+CDMA)" }
        if platform == "iPhone5,3"    { return "iPhone 5c (GSM)" }
        if platform == "iPhone5,4"    { return "iPhone 5c (GSM+CDMA)" }
        if platform == "iPhone6,1"    { return "iPhone 5s (GSM)" }
        if platform == "iPhone6,2"    { return "iPhone 5s (GSM+CDMA)" }
        if platform == "iPhone7,1"    { return "iPhone 6 Plus" }
        if platform == "iPhone7,2"    { return "iPhone 6" }
        if platform == "iPod1,1"      { return "iPod Touch 1G" }
        if platform == "iPod2,1"      { return "iPod Touch 2G" }
        if platform == "iPod3,1"      { return "iPod Touch 3G" }
        if platform == "iPod4,1"      { return "iPod Touch 4G" }
        if platform == "iPod5,1"      { return "iPod Touch 5G" }
        if platform == "iPad1,1"      { return "iPad" }
        if platform == "iPad2,1"      { return "iPad 2 (WiFi)" }
        if platform == "iPad2,2"      { return "iPad 2 (GSM)" }
        if platform == "iPad2,3"      { return "iPad 2 (CDMA)" }
        if platform == "iPad2,4"      { return "iPad 2 (WiFi)" }
        if platform == "iPad2,5"      { return "iPad Mini (WiFi)" }
        if platform == "iPad2,6"      { return "iPad Mini (GSM)" }
        if platform == "iPad2,7"      { return "iPad Mini (GSM+CDMA)" }
        if platform == "iPad3,1"      { return "iPad 3 (WiFi)" }
        if platform == "iPad3,2"      { return "iPad 3 (GSM+CDMA)" }
        if platform == "iPad3,3"      { return "iPad 3 (GSM)" }
        if platform == "iPad3,4"      { return "iPad 4 (WiFi)" }
        if platform == "iPad3,5"      { return "iPad 4 (GSM)" }
        if platform == "iPad3,6"      { return "iPad 4 (GSM+CDMA)" }
        if platform == "iPad4,1"      { return "iPad Air (WiFi)" }
        if platform == "iPad4,2"      { return "iPad Air (GSM)" }
        if platform == "iPad4,3"      { return "iPad Air (LTE)" }
        if platform == "iPad4,4"      { return "iPad Mini 2 (WiFi)" }
        if platform == "iPad4,5"      { return "iPad Mini 2 (GSM)" }
        if platform == "iPad4,6"      { return "iPad Mini 2 (LTE)" }
        if platform == "iPad4,7"      { return "iPad Mini 3 (WiFi)" }
        if platform == "iPad4,8"      { return "iPad Mini 3 (GSM)" }
        if platform == "iPad4,9"      { return "iPad Mini 3 (LTE)" }
        if platform == "iPad5,3"      { return "iPad Air 2 (WiFi)" }
        if platform == "iPad5,4"      { return "iPad Air 2 (GSM)" }
        if platform == "i386"         { return "Simulator" }
        if platform == "x86_64"       { return "Simulator" }
        return platform
    }
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    func getHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
