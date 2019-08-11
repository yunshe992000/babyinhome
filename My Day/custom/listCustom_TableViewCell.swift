//
//  listCustom_TableViewCell.swift
//  My Day
//
//  Created by bolin on 2019/7/17.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class listCustom_TableViewCell: UITableViewCell {
    @IBOutlet weak var listMood: UILabel!
    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var listAddress: UILabel!
    @IBOutlet weak var listTime: UILabel!
    
    @IBOutlet weak var listTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
