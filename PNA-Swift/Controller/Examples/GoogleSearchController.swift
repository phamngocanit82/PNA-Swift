//
//  GoogleMapSearchController.swift
//  PNA-Swift
//
//  Created by An on 5/7/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
protocol GoogleSearchControllerDelegate: NSObjectProtocol {
    func getPlaceMark(address:String, coordinate:CLLocationCoordinate2D)
}
class GoogleSearchController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var gmsAutocompleteFetcher: GMSAutocompleteFetcher?
    var gmsAutocompleteModelArray:[GMSAutocompleteModel] = []
    var locationManager = CLLocationManager()
    var checkLocation = false
    weak var delegate: GoogleSearchControllerDelegate?
    var isQueryLocation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let gmsAutocompleteFilter = GMSAutocompleteFilter()
        gmsAutocompleteFilter.type = .noFilter
        let neBoundsCorner = CLLocationCoordinate2D(latitude: Global.MAP_LATITUDE, longitude: Global.MAP_LONGITUDE)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: Global.MAP_LATITUDE, longitude: Global.MAP_LONGITUDE)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner, coordinate: swBoundsCorner)
        gmsAutocompleteFetcher = GMSAutocompleteFetcher(bounds: bounds, filter: gmsAutocompleteFilter)
        gmsAutocompleteFetcher?.delegate = self
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        gmsAutocompleteFetcher?.sourceTextHasChanged(searchTextField.text!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GoogleSearchController : CLLocationManagerDelegate{
    func getGeocodeLocation (location: CLLocation ) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
               return
            }
            if placemarks!.count > 0 {
                let pm: CLPlacemark! = placemarks?[0]
                var address:String = ""
                if let subThoroughfare = pm.subThoroughfare {
                    address = address + "\(subThoroughfare), "
                }
                if let thoroughfare = pm.thoroughfare {
                    address = address + "\(thoroughfare), "
                }
                if let locality = pm.locality {
                    address = address + "\(locality)"
                }
                if let locality = pm.country {
                    address = address + "\(locality)"
                }
                if let delegate = self.delegate {
                    delegate.getPlaceMark(address: address, coordinate: location.coordinate)
                }
            }
        })
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(checkLocation==false){
            checkLocation = true
            let location = CLLocation(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
            getGeocodeLocation(location: location)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
extension GoogleSearchController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.gmsAutocompleteModelArray.removeAll()
        for prediction in predictions {
            let address: String = prediction.attributedPrimaryText.string + " " + (prediction.attributedSecondaryText?.string)!
            let placeID: String = prediction.placeID!
            var gmsAutocompleteModel: GMSAutocompleteModel = GMSAutocompleteModel()
            gmsAutocompleteModel = gmsAutocompleteModel.setData(address, placeID)
            self.gmsAutocompleteModelArray.append(gmsAutocompleteModel)
        }
        tableView.reloadData()
    }
    func didFailAutocompleteWithError(_ error: Error) {
    }
}
extension GoogleSearchController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let gmsAutocompleteModel:GMSAutocompleteModel = self.gmsAutocompleteModelArray[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = gmsAutocompleteModel.address
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.gmsAutocompleteModelArray.count)
        return self.gmsAutocompleteModelArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.isQueryLocation) {
            return
        }
        self.isQueryLocation = true
        let gmsAutocompleteModel:GMSAutocompleteModel = self.gmsAutocompleteModelArray[indexPath.row]
        let placesClient = GMSPlacesClient()
        print(gmsAutocompleteModel.placeId)
        placesClient.lookUpPlaceID(gmsAutocompleteModel.placeId!) { (places, error) in
            self.isQueryLocation = false
            if error == nil {
                if let place = places {
                    if let delegate = self.delegate {
                        delegate.getPlaceMark(address:gmsAutocompleteModel.address!, coordinate: place.coordinate)
                    }
                }
            }
        }
    }
}
