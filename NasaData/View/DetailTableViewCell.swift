//
//  DetailTableViewCell.swift
//  NasaData
//
//  Created by yacheng on 2021/4/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var shortTextLabel: UILabel!{
        didSet{
            shortTextLabel.numberOfLines = 0
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
