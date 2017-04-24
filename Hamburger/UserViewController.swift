//
//  UserViewController.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/23/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userId: String!
    var tweets: [Tweet]!
    
    @IBOutlet weak var userTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.dataSource = self
        userTableView.delegate = self
        
        TwitterClient.sharedInstance?.userTimeline(userId: userId!, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.userTableView.reloadData()
        }, failure: { (error: Error) in
            print(error)
        })
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
        let cell = userTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        
        let tweet = tweets![indexPath.row] as Tweet
        
        let user = tweet.user! as User
        //cell.tweet = tweet
        
        cell.userPost.text = (tweet.text! as NSString) as String
        cell.userName.text = (user.name! as NSString) as String
        cell.userHandle.text = "@" + ((user.screenName!) as String) as String
        cell.userProfileImage.setImageWith((user.profileImageUrl as? URL)!)
        //cell.retweetCount.text = String(tweet.retweetCount)
        
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
