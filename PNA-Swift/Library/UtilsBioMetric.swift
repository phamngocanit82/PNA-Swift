//
//  UtilsBioMetric.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/11/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
class UtilsBioMetric: NSObject {
    static let sharedInstance = UtilsBioMetric()
    func actionAuthentication(){
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "", success: {
            self.showLoginSucessAlert()
        }, failure: { [weak self] (error) in
            if error == .canceledByUser || error == .canceledBySystem {
                return
            }else if error == .biometryNotAvailable {
                self?.showErrorAlert(message: error.message())
            }else if error == .fallback {
            }else if error == .biometryNotEnrolled {
                self?.showGotoSettingsAlert(message: error.message())
            }else if error == .biometryLockedout {
                self?.showPasscodeAuthentication(message: error.message())
            }else {
                self?.showErrorAlert(message: error.message())
            }
        })
    }
    func showPasscodeAuthentication(message: String) {
        BioMetricAuthenticator.authenticateWithPasscode(reason: message, success: {
            self.showLoginSucessAlert()
        }) { (error) in
            print(error.message())
        }
    }
    func showAlert(title: String, message: String) {
        
    }
    func showLoginSucessAlert() {
        showAlert(title: "Success", message: "Login successful")
    }
    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }
    func showGotoSettingsAlert(message: String) {
        
    }
}
