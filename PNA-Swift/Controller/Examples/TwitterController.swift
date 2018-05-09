//
//  TwitterController.swift
//  PNA-Swift
//
//  Created by An on 5/2/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import TwitterKit
@objc protocol TwitterControllerDelegate {
    func login(viewController: TwitterController, didAuthWith session: TWTRSession)
    func loginDidClearAccounts(viewController: TwitterController)
}
class TwitterController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var prototypeCell: TWTRTweetTableViewCell?
    var isLoadingTweets = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.prototypeCell = TWTRTweetTableViewCell(style: .default, reuseIdentifier: "TweetCell")
        self.tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "TweetCell")
        loadTweets()
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
                print(session)
            }
        }
    }
    func loadTweets() {
        if self.isLoadingTweets {
            return
        }
        self.isLoadingTweets = true
        let tweetIDs = ["20","266031293945503744", "440322224407314432"];
        let client = TWTRAPIClient()
        client.loadTweets(withIDs: tweetIDs) { (twttrs, error) -> Void in
            if ((twttrs) != nil) {
                for i in twttrs! {
                    self.tweets.append(i as TWTRTweet)
                }
            } else {
                print(error as Any)
            }
        }
    }
}
extension TwitterController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TWTRTweetTableViewCell
        cell.tweetView.delegate = self
        let tweet = tweets[indexPath.row]
        cell.configure(with: tweet)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = self.tweets[indexPath.row]
        self.prototypeCell?.configure(with: tweet)
        return TWTRTweetTableViewCell.height(for: tweet, style: TWTRTweetViewStyle.compact, width: self.view.bounds.width, showingActions: false)
    }
}
extension TwitterController: TWTRTweetViewDelegate{
    func tweetView(_ tweetView: TWTRTweetView!, didSelect tweet: TWTRTweet!) {
        let webViewController = UIViewController()
        let webView = UIWebView(frame: webViewController.view.bounds)
        webView.loadRequest(URLRequest(url: tweet.permalink))
        webViewController.view = webView
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
}
