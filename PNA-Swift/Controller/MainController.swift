//
//  MainController.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/3/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import SWRevealViewController
class MainController: ViewController {
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

