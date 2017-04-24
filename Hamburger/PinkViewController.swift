//
//  PinkViewController.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/21/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class PinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetViewCellRetweetDelegate {
    
    var tweets: [Tweet]!
    
    var refreshControl: UIRefreshControl!
    

    @IBOutlet weak var tweetTableView: UITableView!
    
    @IBAction func onLogoutTap(_ sender: Any) {
        print("onLogout")
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func retweet(tweetViewCell: TweetViewCell) {
        print("TweetsViewController -> retweet")
        TwitterClient.sharedInstance?.retweet(id: tweetViewCell.tweet!.id!)
    }
    
    
    @IBAction func onNewTweet(_ sender: Any) {
        print("New Tweet")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTweetViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", for: UIControlEvents.valueChanged)
        tweetTableView.insertSubview(refreshControl, at: 0)
    
        // various timelines
        //TwitterClient.sharedInstance?.profileTimeline(success: { (tweets: [Tweet]) in
        //TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets: [Tweet]) in
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
        for tweet in tweets {
            //print(tweet.text!)
        }
        self.tweets = tweets
        self.tweetTableView.reloadData()
        }, failure: { (error: Error) in
            print(error)
        })
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
    
            for tweet in tweets {
                print(tweet.text!)
            }
            self.tweets = tweets
            self.tweetTableView.reloadData()
        }, failure: { (error: Error) in
            print(error)
        })
        self.refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetViewCell", for: indexPath) as! TweetViewCell
    
        cell.retweetDelegate = self
    
        let tweet = tweets![indexPath.row] as Tweet
    
        let user = tweet.user! as User
        cell.tweet = tweet
    
        cell.post.text = (tweet.text! as NSString) as String
        cell.name.text = (user.name! as NSString) as String
        cell.handle.text = "@" + ((user.screenName!) as String) as String
        cell.profileImageView.setImageWith((user.profileImageUrl as? URL)!)
        cell.retweetCount.text = String(tweet.retweetCount)
    
        print("row \(indexPath.row)")
        return cell
    }
    
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! TweetViewCell
        let indexPath = tweetTableView.indexPath(for: cell)
        let tweet = tweets![(indexPath?.row)!]
        
        let newUser = tweet.user!
        print(newUser.name!)
        print(newUser.id!)

        let userViewController = segue.destination as! UserViewController
        userViewController.userId = newUser.id!
        
    }

}
