//
//  GridCollectionViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell, Reusable {

    // let colors = [UIColor.yellow, .red, .green, .blue]
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // backgroundColor = colors.randomElement()
    }
    
    func configure(withStar star: People) {
        nameLabel.text = star.name
    }
}
