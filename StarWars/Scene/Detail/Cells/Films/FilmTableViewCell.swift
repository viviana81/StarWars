//
//  FilmTableViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

class FilmTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(withFilm film: Film) {
        titleLabel.text = film.title
        messageLabel.text = film.message
        dateLabel.text = film.date
    }
}
