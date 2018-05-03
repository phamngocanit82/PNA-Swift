//
//  FaceBookController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

class FaceBookController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionLogin(_ sender: Any) {
        UtilsFaceBook.sharedInstance.actionLogin(self, _completeHandle: { result, access_token in
            if (result == nil) {
                
            }
            else {
                let name = result?.object(forKey: "name") as? String
                if (name != nil){
                    self.nameLabel.text = name
                }
                let email = result?.object(forKey: "email") as? String
                if (email != nil){
                    self.emailLabel.text = email
                }
                let picture:NSDictionary = (result?.object(forKey: "picture") as? NSDictionary)!
                UtilsLog.log(self, message: picture)
                if (picture.count>0){
                    let data:NSDictionary = picture.object(forKey: "data") as! NSDictionary
                    self.imgView.setImageURL(data.object(forKey: "url") as! String)
                }
            }
        })
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
