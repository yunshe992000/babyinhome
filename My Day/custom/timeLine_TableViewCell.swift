//
//  timeLine_TableViewCell.swift
//  My Day
//
//  Created by bolin on 2019/7/14.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class timeLine_TableViewCell: UITableViewCell {

    @IBOutlet weak var babyImg: UIImageView!
    @IBOutlet weak var babyName: UILabel!
    
    @IBOutlet weak var babyGender: UILabel!
    @IBOutlet weak var babyBirth: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
