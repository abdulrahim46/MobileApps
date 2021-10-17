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
    
    fileprivate let collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let descriptionLb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let overView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.6)
        return view
    }()
    
    fileprivate let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLabel()
        setupView()
        fetchDetails()
        collectionView.isHidden = true
        descriptionLabel.isHidden = true
    }
    
    
    func setupCollectionView() {
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionV.backgroundColor = .clear
        [collectionV, overView, priceLabel, ratingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: view.topAnchor),
            collectionV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionV.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35),
            
            overView.topAnchor.constraint(equalTo: view.topAnchor),
            overView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overView.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: overView.trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ratingLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    func setupLabel() {
        view.addSubview(descriptionLb)
        NSLayoutConstraint.activate([
            descriptionLb.topAnchor.constraint(equalTo: collectionV.bottomAnchor, constant: 10),
            descriptionLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //descriptionLb.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
    }
    
    func setupView() {
        title = mobile?.title
        descriptionLabel.text = mobile?.description
        descriptionLb.text = mobile?.description
        priceLabel.text = "Price: $\(mobile?.price ?? 0)"
        ratingLabel.text = "Rating: \(mobile?.rating ?? 0)"
    }
    
    private func fetchDetails() {
        let id:String = String(mobile?.id ?? 0)
        viewModel.getAllImages(id: id, completion: { [weak self] res, err  in
            DispatchQueue.main.async {
                self?.collectionV.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DetailCollectionViewCell else {
            fatalError("Could not dequeue DetailCollectionviewCell")
        }
        cell.configure(images: viewModel.details[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: view.bounds.height * 0.35)
    }
}
