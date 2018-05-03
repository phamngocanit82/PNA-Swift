//
//  SocketController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import SocketIO
class SocketController: UIViewController {
    @IBOutlet weak var moveView: UIView!
    let manager = SocketManager(socketURL: URL(string: "http://10.183.2.13:3000")!, config: [.log(true), .compress])
    var socket:SocketIOClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = manager.defaultSocket
        socket.connect()
        socket.on("ios position receive") {data, ack in
            let arr = data[0]  as! Array<CGFloat>
            self.moveView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, arr[0] , arr[1], 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func panMove(_ sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: view)
        socket.emit("ios position send", with: [[point.x,point.y]])
    }
    func closeSocket(){
        socket.removeAllHandlers()
        socket.disconnect()
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
