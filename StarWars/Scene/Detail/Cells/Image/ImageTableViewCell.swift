//
//  ImageTableViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var starImage: UIImageView!
    
    func configure(withPeople people: People) {
        
        if let id = people.id {
            let string = "http://mobile.aws.skylabs.it/mobileassignments/swapi/\(id).png"
            let url = URL(string: string)
            starImage.kf.setImage(with: url)
        }
    }
}
