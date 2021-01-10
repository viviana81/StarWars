//
//  BaseCollectionViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 10/01/21.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    var imageDownloadTask: DownloadTask?
    
    func configure(withStar star: People) {
        nameLabel.text = star.name
        if let id = star.id {
            let string = "http://mobile.aws.skylabs.it/mobileassignments/swapi/\(id).png"
            let url = URL(string: string)
            imageDownloadTask = starImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageDownloadTask?.cancel()
        starImage.image = nil
        nameLabel.text = nil
    }
}
