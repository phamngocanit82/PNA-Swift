import UIKit
class MapModel: NSObject{
    var id:Int = 0
    var address:String?
    var shopLocationModel:ShopLocationModel = ShopLocationModel()
    func parseData (_ _dic:NSDictionary) -> MapModel {
        id = _dic.value(forKey: "id") as! Int
        address = _dic.value(forKey: "address") as? String
        shopLocationModel = shopLocationModel.parseData(_dic.object(forKey: "shop_location") as! NSDictionary)
        return self
    }
}
