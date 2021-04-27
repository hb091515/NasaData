//
//  NasaDataCollectionViewCell.swift
//  NasaData
//
//  Created by yacheng on 2021/4/21.
//

import UIKit

class NasaDataCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var NasaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.numberOfLines = 0
        }
    }
    var nasaData:NasaData!
    
    func update(with nasaData: NasaData) {
        self.nasaData = nasaData
        titleLabel.text = nasaData.title
        NasaImage.image = UIImage(systemName: "photo")
        NetworkController.shared.fetchImage(url: URL(string: nasaData.url)!) {[weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if nasaData.title == self.nasaData.title {
                    self.NasaImage.image = image
                }
            }
        }
    }
    
    
}
