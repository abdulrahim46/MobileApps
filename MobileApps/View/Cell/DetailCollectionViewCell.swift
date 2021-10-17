//
//  DetailCollectionViewCell.swift
//  MobileApps
//
//  Created by Abdul Rahim on 17/10/21.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(images: MobileDetail) {
        if var imageData = images.image {
            if imageData.hasPrefix("www") {
                imageData = "http://" + imageData
            }
            imageView.sd_setImage(with: URL(string: imageData),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .continueInBackground,
                                  completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
