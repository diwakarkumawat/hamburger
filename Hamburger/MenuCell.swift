//
//  MenuCell.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/21/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    
    @IBOutlet weak var menuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
