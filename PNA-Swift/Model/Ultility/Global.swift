import Foundation
import UIKit
struct INSTAGRAM_IDS {
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_APIURl  = "https://api.instagram.com/v1/users/self/?access_token="
    static let INSTAGRAM_CLIENT_ID  = "97cf5d4c35314559972c3e6e8c98c349"
    static let INSTAGRAM_CLIENTSERCRET = "530847243f75472b9d802b5d5efdba95"
    static let INSTAGRAM_REDIRECT_URI = "https://mycafebo.nescafe.com"
    static let INSTAGRAM_ACCESS_TOKEN =  "access_token"
    static let INSTAGRAM_SCOPE = "likes+comments+relationships"
}
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
    
    static let RETURN_CODE_BAD_REQ = 400
    static let RETURN_CODE_BAD_FOR = 403
    static let RETURN_CODE_NOT_ACCEPT = 206
    static let RETURN_CODE_SUCCESS = 200
    static let RETURN_CODE_LOCKED = 423
    static let RETURN_CODE_EXPIRE_TOKEN = 401
    
    static let API_CODE_SUCCESS = 0
    static let API_CODE_EXPIRE = 1
    static let API_CODE_BAD_REQ = 2
    static let API_CODE_ERROR = 3
    static let API_CODE_NO_NETWORK = 4
    
    static let AUTH_USERNAME = "username"
    static let AUTH_PASS = "pass"
    
    static let DEFAULT_LOAD_IMAGE = "default_image.png"
    static let LOAD_IMAGE_BACKGROUND_COLOR = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    static let LOAD_IMAGE_ACTIVITY_INDICATOR_COLOR = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    
    static let GOOGLE_MAP = "AIzaSyDg2tlPcoqxx2Q2rfjhsAKS-9j0n3JA_a4"
    static let DATABASE_NAME = "PNA.db"
    static let PASS_SQL = "aimabiet123"
    static let MAP_LATITUDE = 10.783000716441
    static let MAP_LONGITUDE = 106.6972613435
    
    static let INSTAGRAM_URL = "www.instagram.com"
    static let INSTAGRAM_URL_API = "api.instagram.com"
    
    
}
