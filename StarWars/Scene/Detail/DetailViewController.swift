//
//  DetailViewController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

class DetailViewController: UITableViewController {
    
    enum State {
        case idle
        case loading
        case loaded(films: [Film], vehicles: [Vehicle])
    }
    
    enum Section {
        case photo
        case detail
        case films(films: [Film])
        case vehicles(vehicles: [Vehicle])
        
        var header: String {
            switch self {
            case .photo:
                return "Immagine"
            case .detail:
                return "Caratteristiche"
            case .films:
                return "Film"
            case .vehicles:
                return "Veicoli"
            }
        }
        
        var numberOfRows: Int {
            switch self {
            case .photo:
                return 1
            case .detail:
                return 1
            case .films(let films):
                return films.count
            case .vehicles(let vehicles):
                return vehicles.count
            }
        }
    }
    
    // MARK: - Vars
    var films: [Film] = []
    var vehicles: [Vehicle] = []
    
    var sections: [Section] {
        return [
            .photo,
            .detail,
            .films(films: films),
            .vehicles(vehicles: vehicles)
        ]
    }
    
    var status: State = .idle {
        didSet {
            
            switch status {
            case .idle: break
            case .loading: break
            case .loaded(let films, let vehicles):
                self.films = films
                self.vehicles = vehicles
                tableView.reloadData()
            }
        }
    }
    
    private let star: People
    
    init(star: People) {
        self.star = star
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewControllers lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ImageTableViewCell.self)
        tableView.register(StarDetailTableViewCell.self)
        tableView.register(FilmTableViewCell.self)
        tableView.register(VehicleTableViewCell.self)
        
    }
}

extension DetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = sections[section]
        return section.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .photo:
            let cell: ImageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .detail:
            let cell: StarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(withStar: star)
            return cell
        case .films(let films):
            let cell: FilmTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .vehicles(let vehicles):
            let cell: VehicleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell

        }
    
        /*
         
         se la sezione è di tipo immagine {
            dequeue della cella tipo immagine
            configuro cella immagine
            restituisco cella
         } altrimenti se è cella dettagli {
         
         } altrimenti se è cella films {
            deuqueue della cella tipo film
            recupero il film partendo dalla sezione
            configuro la cella con il film
            restitituisco la cella
         }
         
         */
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .photo:
            return section.header
        case .detail:
            return section.header
        case .films:
            return section.header
        case .vehicles:
            return section.header
        }
    }
}
