//
//  User.swift
//  TwitterClient
//
//  Created by Kumawat, Diwakar on 4/11/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenName: NSString?
    var profileImageUrl: NSURL?
    var profileUrl: NSURL?
    var profileImageStr: NSString?
    var tagline: NSString?
    var userDict: NSDictionary
    var followers: Int?
    var friendsCount: Int?
    var profileBGImageUrl: NSString?
    var retweetCount: Int?
    
    init(dict: NSDictionary) {
        self.userDict = dict
        print(dict)
        name = dict["name"] as? String as NSString?
        screenName = dict["screen_name"] as? NSString
        tagline = dict["description"] as? NSString
        var profileImageUrlStr = dict["profile_image_url_https"] as? NSString
        var profileUrlStr = dict["profile_image_url"] as? NSString
        
        if let _profileUrlString = profileImageUrlStr {
            profileImageUrl = URL(string: _profileUrlString as String) as NSURL?
            profileImageUrlStr = _profileUrlString
        }
        
        if let _profileUrlStr = profileUrlStr {
            profileUrl = URL(string: _profileUrlStr as String) as NSURL?
        }
        
        followers = dict["followers_count"] as? Int
        friendsCount = dict["friends_count"] as? Int
        
        retweetCount = dict["statuses_count"] as? Int
        
        var profileBGImageUrlStr = dict["profile_background_image_url"] as? NSString
        if let _profileBGImageUrlStr = profileBGImageUrlStr {
            //profileBGImageUrl = URL(string: _profileBGImageUrlStr as String) as NSURL?
            profileBGImageUrl = _profileBGImageUrlStr
        }
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dict: dictionary)
                }
                return _currentUser
            }
            return nil
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.userDict, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                //defaults.set(nil, forKey: "currentUserData")
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
}
