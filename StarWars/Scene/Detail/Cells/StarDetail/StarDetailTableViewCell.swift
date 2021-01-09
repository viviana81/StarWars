//
//  StarDetailTableViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

class StarDetailTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    
    func configure(withStar star: People) {
        nameLabel.text = star.name
        heightLabel.text = star.height
        massLabel.text = star.mass
        eyeColorLabel.text = star.eyeColor
    }
}
