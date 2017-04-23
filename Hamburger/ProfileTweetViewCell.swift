//
//  ProfileTweetViewCell.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/22/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class ProfileTweetViewCell: UITableViewCell {
    
    var tweet: Tweet!
    
    
    @IBOutlet weak var profileTweetImageView: UIImageView!
    @IBOutlet weak var profilePost: UILabel!
    @IBOutlet weak var profileHandle: UILabel!
    @IBOutlet weak var profileName: UILabel!

    @IBOutlet weak var retweetCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileTweetImageView.layer.cornerRadius = 4
        profileTweetImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
