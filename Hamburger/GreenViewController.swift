//
//  GreenViewController.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/21/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mentionsTableView: UITableView!
    var tweets: [Tweet]!
    
    var refreshControl: UIRefreshControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        mentionsTableView.delegate = self
        mentionsTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", for: UIControlEvents.valueChanged)
        mentionsTableView.insertSubview(refreshControl, at: 0)
        
        // various timelines
        //TwitterClient.sharedInstance?.profileTimeline(success: { (tweets: [Tweet]) in
            TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets: [Tweet]) in
            //TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets {
                //print(tweet.text!)
            }
            self.tweets = tweets
            self.mentionsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error)
        })
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance?.profileTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets {
                print(tweet.text!)
            }
            self.tweets = tweets
            self.mentionsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error)
        })
        self.refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("number of rows")
        
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = mentionsTableView.dequeueReusableCell(withIdentifier: "MentionsTweetViewCell", for: indexPath) as! MentionsTweetViewCell
        
        //cell.retweetDelegate = self
        
        let tweet = tweets![indexPath.row] as Tweet
        
        let user = tweet.user! as User
        cell.tweet = tweet
        
        cell.mentionsPost.text = (tweet.text! as NSString) as String
        cell.mentionsName.text = (user.name! as NSString) as String
        cell.mentionsHandle.text = "@" + ((user.screenName!) as String) as String
        cell.mentionsImageView.setImageWith((user.profileImageUrl as? URL)!)
        
        print("row \(indexPath.row)")
        return cell
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
