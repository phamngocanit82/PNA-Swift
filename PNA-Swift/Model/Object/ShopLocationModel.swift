import UIKit
class ShopLocationModel: NSObject {
    var longitude:NSNumber?
    var latitude:NSNumber?
    func parseData (_ _dic:NSDictionary) -> ShopLocationModel {
        longitude = _dic.object(forKey: "longitude") as? NSNumber
        latitude = _dic.object(forKey: "latitude") as? NSNumber
        return self
    }
}
