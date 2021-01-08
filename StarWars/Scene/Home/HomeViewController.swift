//
//  HomeViewController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit

class HomeViewController: UIViewController {
     
    // MARK: - Vars
    private var collectionLayout: CollectionLayout = .list {
        didSet {
            starCollectionView.setCollectionViewLayout(collectionLayout.layout, animated: true)
           
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: collectionLayout == .grid ?  "list.dash" : "square.grid.3x2")
        }
    }
    
    lazy private var starCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout.layout)
        collection.dataSource = self
        collection.register(GridCollectionViewCell.self)
        return collection
    }()
    
    // MARK: - ViewControllers lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starCollectionView.pin(to: view)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x2"), style: .done, target: self, action: #selector(changeLayout))
    }
    
    // MARK: - Actions
    
    @objc
    private func changeLayout() {
        
        collectionLayout = collectionLayout == .list ? .grid : .list
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GridCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
