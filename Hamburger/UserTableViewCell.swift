//
//  UserTableViewCell.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/23/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userPost: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
