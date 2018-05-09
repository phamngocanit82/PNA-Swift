//
//  MapAutoCompleteObj.swift
//  MyCafe
//
//  Created by NgocAn Pham on 3/2/18.
//  Copyright © 2018 BaTan Nguyen. All rights reserved.
//

import UIKit

class GMSAutocompleteModel: NSObject {
    var address : String?
    var placeId : String?
    func setData(_ _address: String, _ _placeId: String) -> GMSAutocompleteModel {
        address = _address
        placeId = _placeId
        return self
    }
}
