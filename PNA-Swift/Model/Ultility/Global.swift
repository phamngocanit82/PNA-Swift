import Foundation
import UIKit
struct Global {
    static let BORDER_BUTTON_COLOR = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    static let BORDER_LABEL_COLOR = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    static let BORDER_VIEW_COLOR = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    static let BORDER_IMAGEVIEW_COLOR = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    
    static let FONT_NAME_NORMAL = "arial"
    static let FONT_SIZE_NORMAL:CGFloat = 13
    
    static let LANGUAGE_PREFIX = "en:"
    static let LANG_FILE_NAME = ""
    static var LANG_JSON = [AnyHashable:Any]()
    
    static let BASE_URL = "https://stag.mycafebo.nescafe.com/app_dev.php"
    static let NETWORK_METHOD_GET = 0
    static let NETWORK_METHOD_POST = 1
    static let NETWORK_METHOD_PUT = 2
    static let NETWORK_METHOD_DELETE = 3
    
    static let AUTH_USERNAME = "username"
    static let AUTH_PASS = "pass"
    
    static let DEFAULT_LOAD_IMAGE = "default_image.png"
    static let LOAD_IMAGE_BACKGROUND_COLOR = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    static let LOAD_IMAGE_ACTIVITY_INDICATOR_COLOR = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    
    static let DATABASE_NAME = "PNA.db"
    static let PASS_SQL = "aimabiet123"
    static let MAP_LATITUDE = 10.783000716441
    static let MAP_LONGITUDE = 106.6972613435
}
