//
//  ViewController.swift
//  PNA-Swift
//
//  Created by An on 4/17/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import SWRevealViewController
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.revealViewController() != nil){
            self.revealViewController().rearViewRevealWidth = 150
            self.revealViewController().delegate = self
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: SWRevealViewControllerDelegate {
    func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
        if (self.revealViewController().frontViewPosition == FrontViewPosition.left) {
            UtilsLog.log(self, message: "FrontViewPosition.left")
        }
        else {
        }
    }
}
