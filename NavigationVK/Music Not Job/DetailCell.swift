//
//  DetailCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import UIKit

class DetailCell: UITableViewCell {

        @IBOutlet weak var trackDurationLabel: UILabel!
        @IBOutlet weak var trackNameLabel: UILabel!
        @IBOutlet weak var trackNumberButton: UIButton!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
