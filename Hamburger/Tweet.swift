//
//  Tweet.swift
//  TwitterClient
//
//  Created by Kumawat, Diwakar on 4/11/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int?
    var user: User?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dict: NSDictionary) {
        user = User(dict: dict["user"] as! NSDictionary)
        text = dict["text"] as? String
        retweetCount = (dict["retweet_count"] as? Int) ?? 0
        favoritesCount = (dict["favorites_count"] as? Int) ?? 0
        id = dict["id"] as? Int
        
        let ts = dict["created_at"] as? String
        if let timestampStr = ts {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampStr) as NSDate?
        }
    }
    
    class func tweetsWithArray(dicts: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dict in dicts {
            let tweet = Tweet(dict: dict)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
