//
//  MainController.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/3/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import MapKit
import SWRevealViewController
class MainController: ViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var mapKitAnnotationArray:[MapKitAnnotation] = []
    var mapChangedFromUserInteraction = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            mapView.register(MapKitAnnotationView.self, forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier)
        }
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:Global.MAP_LATITUDE, longitude:Global.MAP_LONGITUDE)
            self.setMapCenter(location)
        }
        mapView.tintColor = .red;
        
        let filePath = Bundle.main.path(forResource: "map_data", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .mappedIfSafe)
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let array:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
            for item in array {
                var mapModel: MapModel = MapModel()
                mapModel = mapModel.parseData(item as! NSDictionary)
                let mapKitAnnotation = MapKitAnnotation(mapModel)
                self.mapKitAnnotationArray.append(mapKitAnnotation)
            }
            for item:MapKitAnnotation in self.mapKitAnnotationArray{
                var isExist:Bool = false
                for annotation in self.mapView.annotations{
                    if let mapKitAnnotation = annotation as? MapKitAnnotation{
                        if(mapKitAnnotation.mapModel.id == item.mapModel.id){
                            isExist = true
                            break
                        }
                    }
                }
                if(isExist == false){
                    self.mapView.addAnnotation(item)
                }
            }
        } catch {
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self.menuButton.allTargets.count)
        if (self.revealViewController() != nil && self.menuButton.allTargets.count == 0){
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func setMapCenter(_ _location:CLLocationCoordinate2D){
        let spanX = 0.005
        let spanY = 0.005
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:Global.MAP_LATITUDE, longitude:Global.MAP_LONGITUDE)
        let region = MKCoordinateRegion(center:location , span: MKCoordinateSpanMake(spanX, spanY))
        self.mapView.setRegion(region, animated: false)
        self.mapView.moveCenterByOffSet(offSet: CGPoint(x: 10, y: 0), coordinate: location)
    }
}
extension MainController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = mapView.userLocation.location?.coordinate{
            self.setMapCenter(location)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
}
extension MainController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapKitAnnotation = annotation as? MapKitAnnotation else { return nil }
        let identifier = "MapKitAnnotationView"
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if let view = view as? MapKitAnnotationView {
            view.annotation = mapKitAnnotation
        }
        return view
    }
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizerState.began || recognizer.state == UIGestureRecognizerState.ended ) {
                    return true
                }
            }
        }
        return false
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if (mapChangedFromUserInteraction) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                //for code when changed position
            }
        }
    }
}
extension MainController: MapKitAnnotationViewDelegate {
    func didTapMapKitAnnotationView(_ _mapKitAnnotation: MapKitAnnotation) {
    }
}
