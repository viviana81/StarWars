//
//  FilmDetailViewController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 10/01/21.
//

import UIKit

class FilmDetailViewController: UIViewController {

    @IBOutlet weak var messageTxtView: UITextView!
    
    private let film: Film
    
    init(film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "film.detail.message".localized
        messageTxtView.text = film.message
    }

}
