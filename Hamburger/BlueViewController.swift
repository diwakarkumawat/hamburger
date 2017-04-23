//
//  BlueViewController.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/21/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]!
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.delegate = self
        userTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", for: UIControlEvents.valueChanged)
        userTableView.insertSubview(refreshControl, at: 0)
        
        //let currentUser = User.currentUser!
        let currentUser = User._currentUser!
        print(currentUser.name!)
        print(currentUser.screenName!)
        print(currentUser.profileImageUrl!)
        print(currentUser.profileBGImageUrl!)
        
        // profile details
        userImageView.setImageWith((User._currentUser?.profileImageUrl as? URL)!)
        name.text = User._currentUser?.name as String?
        handle.text = User._currentUser?.screenName as String?
        
        following.text = "\(User._currentUser!.friendsCount!) FOLLOWING"
        followers.text = "\(User._currentUser!.followers!) FOLLOWERS"

        // various timelines
        TwitterClient.sharedInstance?.profileTimeline(success: { (tweets: [Tweet]) in
        //TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets: [Tweet]) in
        //TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets {
                //print(tweet.text!)
            }
            self.tweets = tweets
            self.userTableView.reloadData()
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
            self.userTableView.reloadData()
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
        let cell = userTableView.dequeueReusableCell(withIdentifier: "ProfileTweetViewCell", for: indexPath) as! ProfileTweetViewCell
        
        //cell.retweetDelegate = self
        
        let tweet = tweets![indexPath.row] as Tweet
        
        let user = tweet.user! as User
        cell.tweet = tweet

        cell.profilePost.text = (tweet.text! as NSString) as String
        cell.profileName.text = (user.name! as NSString) as String
        cell.profileHandle.text = "@" + ((user.screenName!) as String) as String
        cell.profileTweetImageView.setImageWith((user.profileImageUrl as? URL)!)
        
        print("row \(indexPath.row)")
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
