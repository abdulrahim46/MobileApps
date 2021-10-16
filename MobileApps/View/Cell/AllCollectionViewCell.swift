//
//  AllCollectionViewCell.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import UIKit
import SDWebImage

class AllCollectionViewCell: UICollectionViewCell {
    
    //MARK: Views & Properties
    static let reuseIdentifier: String = "AllCollectionViewCell"
    
    var mobile: Mobile?
    var viewModel = FavouriteViewModel()

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
    
    /// Configure the cell data here
    func configure(mobile: Mobile, index: Int) {
        self.mobile = mobile
        title.text = mobile.title
        descriptionLabel.text = mobile.description
        priceLabel.text = "Price: \(mobile.price ?? 0.0)"
        ratingLabel.text = "Rating: \(mobile.rating ?? 0.0)"
        if let imageData = mobile.image {
            imageView.sd_setImage(with: URL(string: imageData),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .continueInBackground,
                                  completed: nil)
        }
        
        if index == 1 {
            favouriteButton.isHidden = true
        } else {
            favouriteButton.isHidden = false
        }

    }
    
    @IBAction func favouriteButtonTap(_ sender: Any) {
        viewModel.saveFavouriteMobile(mobile: mobile!) /// save the data to firebase firestore
        if #available(iOS 13.0, *) {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) /// change the button image after tap
        } else {
            // Fallback on earlier versions
        }
        favouriteButton.isUserInteractionEnabled = false /// disable the button for second use
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mobile = nil
    }
}
