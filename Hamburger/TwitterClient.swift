//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Kumawat, Diwakar on 4/12/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let USER_LOGOUT = "UserLogOut"
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "7ecFpPfPSBNWBXUN5FJcYSsuM", consumerSecret: "eyKr9IeYmpRrGBMivlnd66Cvy0mESsGJt8DURBJlR2ZTdSfU3f")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("got access token")
            
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error?) in
                self.loginFailure?(error!)
            })
            
        }, failure: { (error: Error?) -> Void in
            print(error)
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: TwitterClient.USER_LOGOUT), object: nil)
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterburger://oauth") as! URL, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("got a token")
            //print(requestToken?.token)
            //let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token)") as! URL
            let token = requestToken?.token!
            let urlString = "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)"
            print(urlString)
            let url = NSURL(string: urlString)!
            print(url)
            
            UIApplication.shared.openURL(url as URL)
            
        }, failure: { (error: Error?)  in
            print(error)
            self.loginFailure?(error!)
        })
        
        
    }
    
    //endpoint = "statuses/mentions_timeline.json"
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            let dicts = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dicts: dicts)
            
            success(tweets)
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            failure(error)
        })
    }
    
    // profile Timeline statuses/user_timeline
    func profileTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            let dicts = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dicts: dicts)
            
            success(tweets)
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            failure(error)
        })
    }
    
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            let dicts = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dicts: dicts)
            
            success(tweets)
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            failure(error)
        })
    }
    
    //https://api.twitter.com/1.1/statuses/retweet/:id.json
    func retweet(id: Int) {
        print("Twitterclient -> retweet")
        post("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: URLSessionDataTask, response: Any?) -> Void in
            print("Successfully retweeted")
        }) { (operation: URLSessionDataTask?, error: Error) -> Void in
            print("Failed to retweet")
        }
    }
    
    func postTweet(message: String) {
        print("Twitterclient -> postTweet")
        print(message)
        var encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(encodedMessage)
        var params = NSDictionary()
        params = ["status" : message]
        print("https://api.twitter.com/1.1/statuses/update.json?status=\(encodedMessage!)")
        post("https://api.twitter.com/1.1/statuses/update.json?status=\(encodedMessage!)",
            //post("https://api.twitter.com/1.1/statuses/update.json",
            parameters: nil, success: { (operation: URLSessionDataTask, response: Any?) -> Void in
                print("Successfully Tweeted")
        }) { (operation: URLSessionDataTask?, error: Error) -> Void in
            print("Failed to Tweet")
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        TwitterClient.sharedInstance?.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            //print("account: \(response)")
            let userDict = response as? NSDictionary
            
            let user = User(dict: userDict!)
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenName)")
            print("profileUrl: \(user.profileImageUrl)")
            print("description: \(user.tagline)")
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            print(error)
            failure(error)
        })
        
    }
}
