//
//  MentionsTweetViewCell.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/22/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class MentionsTweetViewCell: UITableViewCell {
    
        var tweet: Tweet!

    @IBOutlet weak var mentionsHandle: UILabel!
    @IBOutlet weak var mentionsImageView: UIImageView!
    @IBOutlet weak var mentionsPost: UILabel!
    @IBOutlet weak var mentionsName: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            mentionsImageView.layer.cornerRadius = 4
            mentionsImageView.clipsToBounds = true
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
    
        @IBAction func retweetAction(_ sender: Any) {
            print("TweetViewCell -> retweet")
        }
        
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
}

