import UIKit
import MapKit
protocol MapKitAnnotationViewDelegate {
    func didTapMapKitAnnotationView(_ _mapKitAnnotation: MapKitAnnotation)
}
class MapKitAnnotation:NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let mapModel : MapModel
    
    init(_ _mapModel: MapModel) {
        self.mapModel = _mapModel
        self.title = ""
        self.locationName = ""
        self.discipline = ""
        self.coordinate = CLLocationCoordinate2D(latitude: (mapModel.shopLocationModel.latitude?.doubleValue)! , longitude: (mapModel.shopLocationModel.longitude?.doubleValue)!)
        super.init()
    }
}
class MapKitAnnotationView: MKAnnotationView {
    open lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        self.addSubview(image)
        return image
    }()
    open lazy var nameLabel: UILabel = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_map_left_arrow")
        imageView.frame = CGRect(x:(image?.size.width)!+4, y: ((image?.size.height)!-(imageView.image?.size.height)!)/2+2, width: (imageView.image?.size.width)!, height: (imageView.image?.size.height)!)
        self.addSubview(imageView)
       
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 190/255.0, green: 190/255.0, blue:190/255.0, alpha: 0.3).cgColor
        label.font = UIFont (name: Global.FONT_NAME_NORMAL, size: Global.FONT_SIZE_NORMAL)
        label.textColor = .black
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    open lazy var clickButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    override var annotation: MKAnnotation? {
        willSet {
            guard let mapKitAnnotation = newValue as? MapKitAnnotation else {return}
            image = UIImage(named: "ic_map_red_pin")
            nameLabel.text = mapKitAnnotation.mapModel.address
            nameLabel.sizeToFit()
            nameLabel.frame = CGRect(x:(image?.size.width)!+10, y: (image?.size.height)!/4-2, width: nameLabel.frame.width+10, height: nameLabel.frame.height+4)
            clickButton.frame = CGRect(x:0, y: 0, width: nameLabel.frame.width+(image?.size.width)!+10, height: (image?.size.height)!)
        }
    }
    @objc func didTapButton(_ sender: UIButton){
        if let mapView = mapView, let delegate = mapView.delegate as? MapKitAnnotationViewDelegate {
            let mapKitAnnotation = annotation as? MapKitAnnotation
            delegate.didTapMapKitAnnotationView(mapKitAnnotation!)
        }
    }
    var mapView: MKMapView? {
        var view = superview
        while view != nil {
            if let mapView = view as? MKMapView { return mapView }
            view = view?.superview
        }
        return nil
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if(!isInside){
            for view in self.subviews{
                isInside = view.frame.contains(point)
                if isInside{
                    break
                }
            }
        }
        return isInside
    }
}
