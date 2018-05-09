//
//  CustomMapkit.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/7/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import MapKit
extension MKMapView {
    func moveCenterByOffSet(offSet: CGPoint, coordinate: CLLocationCoordinate2D) {
        var point = self.convert(coordinate, toPointTo: self)
        point.x += offSet.x
        point.y += offSet.y
        let center = self.convert(point, toCoordinateFrom: self)
        self.setCenter(center, animated: false)
    }
    func centerCoordinateByOffSet(offSet: CGPoint) -> CLLocationCoordinate2D {
        var point = self.center
        point.x += offSet.x
        point.y += offSet.y
        return self.convert(point, toCoordinateFrom: self)
    }
}
