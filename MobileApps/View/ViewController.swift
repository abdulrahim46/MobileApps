//
//  ViewController.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import UIKit
import Segmentio

class ViewController: UIViewController {
    
    //  Views & Properties
    
    @IBOutlet weak var segmentView: Segmentio!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = AllMobileViewModel()
    var mobiles: [Mobile]?
    // LifeCycles methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentio()
        setupCollectionView()
        fetchingMobiles()
    }
    
    // Setting the views
    
    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        /// Assigning data source and background color
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UINib(nibName: "AllCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AllCollectionViewCell.reuseIdentifier)
    }
    
    // Top bar segment setup
    
    func setupSegmentio() {
        let content = [SegmentioItem(title: "All", image: nil),
                       SegmentioItem(title: "Favourite", image: nil)]
        
        let segmentStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Avenir-heavy", size: 16.0)!,
                titleTextColor: UIColor.lightGray
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Avenir-heavy", size: 16.0)!,
                titleTextColor: .black
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Avenir-heavy", size: 16.0)!,
                titleTextColor: UIColor.lightGray
            )
        )
        
        let options = SegmentioOptions(
            backgroundColor: .clear,
            segmentPosition: SegmentioPosition.dynamic,
            scrollEnabled: true,
            indicatorOptions: SegmentioIndicatorOptions.init(type: .bottom, ratio: 1, height: 3, color: .clear),
            horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions.init(type: .none, height: 0, color: UIColor.clear),
            verticalSeparatorOptions: SegmentioVerticalSeparatorOptions.init(ratio: 1.0, color: UIColor.clear),
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: segmentStates
        )
        
        segmentView.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: options
        )
        
        segmentView.selectedSegmentioIndex = 0
        
        segmentView.valueDidChange = { [weak self] segmentio, segmentIndex in
//            let index = LearnModulesSegmentOption.init(rawValue: segmentIndex) ?? LearnModulesSegmentOption.Active
//            self?.handleSegmentSelection(index)
        }
    }
    
    // calling fetch api
    func fetchingMobiles() {
        viewModel.getAllMobiles() { [weak self] mobiles, error in
            self?.mobiles = mobiles
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK:- Extension for collectionview methods
/// CollectionView delegate & datasource methods.

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobiles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionViewCell.reuseIdentifier, for: indexPath) as? AllCollectionViewCell else {
            fatalError("Could not dequeue AllCollectionViewCell")
        }
        cell.configure(mobile: viewModel.mobiles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 10
        return CGSize(width: width, height: 130)
    }
    
    
}

