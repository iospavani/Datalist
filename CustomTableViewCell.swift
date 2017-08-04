//
//  CustomTableViewCell.swift
//  Tableviewswift
//
//  Created by Pavani_ios on 8/2/17.
//  Copyright © 2017 asman. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var urlimageview: UIImageView!
    
    
    @IBOutlet weak var artistName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
