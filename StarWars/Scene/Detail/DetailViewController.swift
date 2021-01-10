//
//  DetailViewController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func getData(star: People)
    func onFilmCellTap(film: Film)
}

class DetailViewController: UITableViewController {
    
    enum State {
        case idle
        case loading
        case filmLoaded(films: [Film])
        case vehicleLoaded(vehicles: [Vehicle])
        case error(error: Error)
    }
    
    enum Section {
        case photo
        case detail
        case films(films: [Film])
        case vehicles(vehicles: [Vehicle])
        
        var header: String {
            switch self {
            case .photo:
                return ""
            case .detail:
                return "header.detail.title".localized
            case .films:
                return "header.films.title".localized
            case .vehicles:
                return "header.vehicles.title".localized
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
            case .filmLoaded(let films):
                self.films = films
                tableView.reloadSections([2], with: .automatic)
            case .vehicleLoaded(let vehicles):
                self.vehicles = vehicles
                tableView.reloadSections([3], with: .automatic)
            case .error(let error):
                showAlert(andMessage: error.localizedDescription)
            }
        }
    }
    weak var delegate: DetailViewControllerDelegate?
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
        delegate?.getData(star: star)
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
            cell.configure(withPeople: star)
            return cell
        case .detail:
            let cell: StarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(withStar: star)
            return cell
        case .films(let films):
            let cell: FilmTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let film = films[indexPath.row]
            cell.configure(withFilm: film)
            return cell
        case .vehicles(let vehicles):
            let cell: VehicleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let vehicle = vehicles[indexPath.row]
            cell.configure(withVehicle: vehicle)
            return cell

        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        header.backgroundColor = .black
        header.tintColor = .white
        
        let label = UILabel(frame: CGRect(x: 23, y: 0, width: 250, height: 50))
        label.font = UIFont.jediFont(ofSize: 24)
            label.textColor = .white
        label.text = sections[section].header
        
        header.addSubview(label)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .films(let films):
            let film = films[indexPath.row]
            delegate?.onFilmCellTap(film: film)
        default:
            break
        }
        
    }
}
