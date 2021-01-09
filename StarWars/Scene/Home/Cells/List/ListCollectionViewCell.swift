//
//  ListCollectionViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(withStar star: People) {
        nameLabel.text = star.name
    }
}
