//
//  MobileCollectionViewCell.swift
//  MobileApps
//
//  Created by Abdul Rahim on 15/10/21.
//

import UIKit

class MobileCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "BottomTableCell"
    
    /// properties & views
    let title = UILabel()
    let detail = UILabel()
    let ratingLabel = UILabel()
    let imageView = UIImageView()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(detail)
        addSubview(ratingLabel)
        addSubview(imageView)
        addSubview(priceLabel)
        setUp()
    }
    
    func setUp() {
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        detail.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
//            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            //authorLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75)
        ])
        
        //style()
        
        configure()
    }
    
    /// cell style setup
//    private func style() {
//        name.font = UIFont.preferredFont(forTextStyle: .headline)
//        name.sizeThatFits(CGSize(width: 10.0, height: 10.0))
//        name.textColor = .label
//
//        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        subtitle.sizeThatFits(CGSize(width: 8.0, height: 8.0))
//        subtitle.textColor = .secondaryLabel
//
//        imageView.layer.cornerRadius = 15
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//
//        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
//        authorLabel.sizeThatFits(CGSize(width: 8.0, height: 8.0))
//        authorLabel.textColor = .systemBlue
//    }
//
    /// configure cell here
    func configure() {
        title.text = "Ipohne"//article.title
        detail.text = "@  lines jdgjdng"//article.description
        priceLabel.text = "nothing"//article.author
        imageView.image = UIImage(named: "mobile")
//        if let imageData = article.image {
//            imageView.sd_setImage(with: URL(string: imageData),
//                                  placeholderImage: UIImage(named: "placeholder"),
//                                  options: .continueInBackground,
//                                  completed: nil)
//        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("Just… no")
    }
}
