import UIKit
import Photos
class UtilsPhotoGallery: NSObject {
    static let sharedInstance = UtilsPhotoGallery()
    var _vc: UIViewController?
    var imagePicker = UIImagePickerController()
    override init() {
    }
    func showOptionList (_ vc : UIViewController, _ _imagePicker: UIImagePickerController) {
        imagePicker = _imagePicker
        _vc = vc
        vc.view.endEditing(true)
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title:"please select", message:"option to select", preferredStyle: .actionSheet)
        
        let cameraActionButton: UIAlertAction = UIAlertAction(title:"from camera", style: .default){ action -> Void in
            self.showCameraSelect()
        }
        actionSheetControllerIOS8.addAction(cameraActionButton)
        
        let photoActionButton: UIAlertAction = UIAlertAction(title:"from photo library", style: .default){ action -> Void in
            self.showPhotoLibrarySelect()
        }
        actionSheetControllerIOS8.addAction(photoActionButton)
        actionSheetControllerIOS8.addAction(UIAlertAction(title:"cancel", style: UIAlertActionStyle.default, handler: nil))
        vc.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    func authorizeToAlbum(completion:@escaping (Bool)->Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        completion(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
        } else {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title:"no camare",
            message:"no camare description",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title:"ok",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        _vc?.present(alertVC, animated: true, completion: nil)
    }
    func showCameraSelect() {
        weak var weakSelf = _vc
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.authorizeToAlbum { (authorized) in
                if authorized == true {
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.cameraCaptureMode = .photo
                    self.imagePicker.modalPresentationStyle = .fullScreen
                    weakSelf?.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        } else {
            noCamera()
        }
    }
    func showPhotoLibrarySelect () {
        weak var weakSelf = _vc
        self.authorizeToAlbum { (authorized) in
            if authorized == true {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                
                weakSelf?.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
}
