//
//  HomeViewController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit
import AVFoundation

protocol HomeViewControllerDelegate: class {
    func getPeople()
    func onCellTap(star: People)
}

class HomeViewController: UIViewController {
    
    // MARK: - Vars
    private var collectionLayout: CollectionLayout = .list {
        didSet {
            starCollectionView.setCollectionViewLayout(collectionLayout.layout, animated: true)
            starCollectionView.reloadSections([0])
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: collectionLayout == .grid ?  "list.dash" : "square.grid.3x2")
        }
    }
    
    lazy private var starCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout.layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(GridCollectionViewCell.self)
        collection.register(ListCollectionViewCell.self)
        return collection
    }()
    
    var people: [People] = [] {
        didSet {
            starCollectionView.reloadData()
        }
    }
    weak var delegate: HomeViewControllerDelegate?
    var soundEffect: AVAudioPlayer?
    
    // MARK: - ViewControllers lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "home.title".localized
        starCollectionView.pin(to: view)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x2"), style: .done, target: self, action: #selector(changeLayout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "speaker"), style: .done, target: self, action: #selector(toggleSound))
        
        delegate?.getPeople()
        prepareAudio()
        
    }
    
    // MARK: - Actions
    
    @objc
    private func changeLayout() {
        
        collectionLayout = collectionLayout == .list ? .grid : .list
    }
    
    @objc
    private func toggleSound() {
        guard let sound = soundEffect else { return }
        if sound.isPlaying {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "speaker")
            soundEffect?.stop()
        } else {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "speaker.slash")
            soundEffect?.play()
        }
    }
    
    func prepareAudio() {
        guard let path = Bundle.main.path(forResource: "star-wars-theme-song.mp3", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        
        soundEffect = try? AVAudioPlayer(contentsOf: url)
        soundEffect?.prepareToPlay()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionLayout == .grid {
            let cell: GridCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let star = people[indexPath.item]
            cell.configure(withStar: star)
            return cell
        } else {
            let cell: ListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let star = people[indexPath.item]
            cell.configure(withStar: star)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == people.count - 1 {
            delegate?.getPeople()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let star = people[indexPath.item]
        delegate?.onCellTap(star: star)
    }
}
