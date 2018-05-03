//
//  SocialNetworkService.swift
//  MyCafe
//
//  Created by An on 4/3/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookCore
import FacebookLogin

typealias SocialHandler = (_ result: AnyObject?, _ access_token: String?) -> ()
class UtilsFaceBook: NSObject {
    static let sharedInstance = UtilsFaceBook()
    var socialHandler: SocialHandler?
    override fileprivate init() {
    }
    func actionLogin(_ controller: UIViewController, _completeHandle: @escaping SocialHandler) {
        socialHandler = _completeHandle
        if FBSDKAccessToken.current() != nil {
            FBSDKLoginManager().logOut()
        }
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = .native
        loginManager.logIn(withReadPermissions:["public_profile", "email"], from: controller) {
            loginResult, error in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = loginResult!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        self.getProfile()
                        loginManager.logOut()
                    }
                }
            }
            else {
                self.socialHandler!(nil, nil)
            }
        }
    }
    private func getProfile(){
        if((FBSDKAccessToken.current()) != nil){
            let access_token = FBSDKAccessToken.current().tokenString!
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    DispatchQueue.main.async {
                        self.socialHandler!(result! as AnyObject, access_token)
                    }
                }
                else {
                    self.socialHandler!(nil, nil)
                }
            })
        }
    }
}
