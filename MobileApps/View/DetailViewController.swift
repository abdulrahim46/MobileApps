//
//  DetailViewController.swift
//  MobileApps
//
//  Created by Abdul Rahim on 17/10/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties & View
    let viewModel = DetailViewModel()
    var mobile: Mobile?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
        fetchDetails()
    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupView() {
        title = mobile?.title
        descriptionLabel.text = mobile?.description
    }
    
    private func fetchDetails() {
        let id:String = String(mobile?.id ?? 0)
        viewModel.getAllImages(id: id, completion: { [weak self] res, err  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
    
    deinit {
        print("release everything")
    }
    
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        //cell.configure()
        // viewModel.configure(item: cell, for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: view.bounds.height * 0.35)
    }
}
