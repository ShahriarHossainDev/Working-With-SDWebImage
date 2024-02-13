//
//  DogCollectionViewCell.swift
//  Working With SDWebImage
//
//  Created by Shishir_Mac on 13/2/24.
//

import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.contentMode = .scaleToFill
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }

}
