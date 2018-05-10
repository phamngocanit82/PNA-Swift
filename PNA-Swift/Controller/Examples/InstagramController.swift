//
//  InstagramController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

class InstagramController: UIViewController {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actionLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Examples", bundle: nil)
        let utilsInstagram:UtilsInstagram = storyboard.instantiateViewController(withIdentifier: "UtilsInstagram")  as! UtilsInstagram
        utilsInstagram.delegate = self
        self.present(utilsInstagram, animated: true, completion: nil)
    }
}
extension InstagramController: UtilsInstagramDelegate {
    func getInstagramUserInfo(_ data: AnyObject, _ token: String) {
    }
}
