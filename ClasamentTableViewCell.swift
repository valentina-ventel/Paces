//
//  ClasamentCellTableViewCell.swift
//  Paces
//
//  Created by Valentina Vențel on 25/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ClasamentTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupProfileCell() {
        
    }
}
