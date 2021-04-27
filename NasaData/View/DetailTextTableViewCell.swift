//
//  DetailTextTableViewCell.swift
//  NasaData
//
//  Created by yacheng on 2021/4/23.
//

import UIKit

class DetailTextTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
