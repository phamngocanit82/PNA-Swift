//
//  UtilsInstagram.swift
//  PNA-Swift
//
//  Created by NgocAn Pham on 5/10/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
protocol UtilsInstagramDelegate: NSObjectProtocol, UIWebViewDelegate {
    func getInstagramUserInfo(_ data: AnyObject, _ token: String)
}
class UtilsInstagram: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    weak var delegate: UtilsInstagramDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cookieJar : HTTPCookieStorage = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! as [HTTPCookie]{
            if cookie.domain == Global.INSTAGRAM_URL ||
                cookie.domain == Global.INSTAGRAM_URL_API {
                cookieJar.deleteCookie(cookie)
            }
        }
        unSignedRequest()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
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
    func unSignedRequest () {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_IDS.INSTAGRAM_AUTHURL, INSTAGRAM_IDS.INSTAGRAM_CLIENT_ID, INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI, INSTAGRAM_IDS.INSTAGRAM_SCOPE])
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        webView.loadRequest(urlRequest)
    }
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false
        }
        return true
    }
    
    func handleAuth(authToken: String)  {
        let url = URL(string: "\(INSTAGRAM_IDS.INSTAGRAM_APIURl)\(authToken)")
        /*let networkConnection = ConnectionManagerUtils()
        networkConnection.instgramSocialData(_url: (url?.absoluteString)!, _showProgressHUB: true, _completeHandle: {
            jsonData in
            DispatchQueue.main.async {
                if (jsonData != nil) {
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.getInstagramUserInfo(jsonData!, authToken)
                }
            }
        })*/
    }
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
    }
}
