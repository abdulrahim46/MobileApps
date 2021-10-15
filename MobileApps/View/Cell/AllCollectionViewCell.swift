//
//  AllCollectionViewCell.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import UIKit

class AllCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "AllCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
       // title.text = ""
    }

}
