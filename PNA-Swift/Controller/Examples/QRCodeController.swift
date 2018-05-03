//
//  QRCodeController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myString = "My string to encode"
        let data = myString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        let image = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        let img = image?.transformed(by: transform)
        myImageView.image = UIImage(ciImage:img!)
        
        //Creating session
        let session = AVCaptureSession()
        //Define capture devcie
        let captureDevice = AVCaptureDevice.default(for: .video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch{
            print ("ERROR")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubview(toFront: square)
        self.view.bringSubview(toFront: myImageView)
        session.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
