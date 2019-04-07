//
//  SchoolCell.swift
//  Dancing Dream
//
//  Created by Wade Li on 4/6/19.
//  Copyright © 2019 Wade Li. All rights reserved.
//

import UIKit

class SchoolCell: UITableViewCell {

    @IBOutlet weak var nameF: UILabel!
    @IBOutlet weak var addressF: UILabel!
    @IBOutlet weak var phoneF: UILabel!
    @IBOutlet weak var styleF: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
