//
//  AllTableViewCell.swift
//  MobileApps
//
//  Created by Abdul Rahim on 16/10/21.
//

import UIKit

class AllTableViewCell: UITableViewCell {
    
    //MARK: Views & Properties
    static let reuseIdentifier: String = "AllTableViewCell"
    
    @IBOutlet weak var mobileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
