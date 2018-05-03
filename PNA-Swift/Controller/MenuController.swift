//
//  MenuController.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/3/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var CellIdentifier:String = "Cell";
        switch ( indexPath.row ){
            case 0:
                CellIdentifier = "map";
                break;
            case 1:
                CellIdentifier = "example";
                break;
            default:
                break;
        }
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)!
        return cell
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

