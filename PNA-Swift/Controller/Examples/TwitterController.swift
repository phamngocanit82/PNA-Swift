//
//  TwitterController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import TwitterKit
class TwitterController: UIViewController, TWTRComposerViewControllerDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func actionLogin(_ sender: Any){
        TWTRTwitter.sharedInstance().logIn { [weak self] (session, error) in
            if let error = error, let weakSelf = self {
            } else if let session = session, let weakSelf = self {
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    self?.nameLabel.text = session.userName
                    if (email != nil) {
                        self?.emailLabel.text = email
                    } else {
                        self?.emailLabel.text = "This user does not have an email address"
                    }
                }
                //self?.shareTwitter()
                self?.getUser(session.userID)
            }
        }
    }
    func shareTwitter(){
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            let composer = TWTRComposerViewController.init(initialText: "UK flag picture will be tweeted", image: UIImage.init(named: "usa"), videoURL: nil)
            composer.delegate = self
            present(composer, animated: true, completion: nil)
        }
    }
    func getUser(_ userId:String){
        let client = TWTRAPIClient()
        client.loadUser(withID: userId) { (user, error) -> Void in
            self.imgView.setImageURL((user?.profileImageURL)!)
        }
    }
    
    func composerDidCancel(_ controller: TWTRComposerViewController) {
        print("composerDidCancel, composer cancelled tweet")
    }
    func composerDidSucceed(_ controller: TWTRComposerViewController, with tweet: TWTRTweet) {
        print("composerDidSucceed tweet published")
    }
    func composerDidFail(_ controller: TWTRComposerViewController, withError error: Error) {
        print("composerDidFail, tweet publish failed == \(error.localizedDescription)")
    }
}

