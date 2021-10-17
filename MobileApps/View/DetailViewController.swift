//
//  DetailViewController.swift
//  MobileApps
//
//  Created by Abdul Rahim on 17/10/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: - Properties & View
    let viewModel = DetailViewModel()
    var mobile: Mobile?
    
    fileprivate let collectionView: UICollectionView = {
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
    
    private var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
   
        return scrollView
    }()
    
    let contentView = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollview)
        setupCollectionView()
        setConstraints()
        setupView()
        fetchDetails()
    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
    }
    
    func setConstraints() {
        [contentView, collectionView, descriptionLb, overView, priceLabel, ratingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollview.addSubview($0)
        }

        NSLayoutConstraint.activate([
            scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollview.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35),
            
            descriptionLb.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            descriptionLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            overView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overView.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: overView.trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ratingLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupView() {
        title = mobile?.title
        descriptionLb.text = mobile?.description
        priceLabel.text = "Price: $\(mobile?.price ?? 0)"
        ratingLabel.text = "Rating: \(mobile?.rating ?? 0)"
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
        //print("release everything")
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
