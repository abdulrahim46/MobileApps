//
//  ViewController.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import UIKit
import Segmentio

class ViewController: UIViewController {
    
    //MARK:  Views & Properties
    
    @IBOutlet weak var segmentView: Segmentio!
    @IBOutlet weak var collectionView: UICollectionView!
    var emptyImageView = UIImageView()
    var noDataLabel = UILabel()
    
    let viewModel = AllMobileViewModel()
    let favourVm = FavouriteViewModel()
    var mobiles = [Mobile]()
    var favouriteMobiles = [Mobile]()
    
    //MARK: LifeCycles methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
        setupSegmentio()
        setupCollectionView()
        setupEmptyView()
        fetchingMobiles()
    }
    
    //MARK: Setting the views
    func addNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sort",
            style: .plain,
            target: self,
            action: #selector(sortButtonAction)
        )
    }
    
    /// setup collectionview
    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        /// Assigning data source and background color
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UINib(nibName: "AllCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AllCollectionViewCell.reuseIdentifier)
    }
    
    func setupEmptyView() {
        emptyImageView.contentMode = UIView.ContentMode.scaleAspectFit
        emptyImageView.frame.size.width = 200
        emptyImageView.frame.size.height = 100
        emptyImageView.center = self.view.center

        emptyImageView.image = UIImage(named: "no-data")
        emptyImageView.isHidden = true
        view.addSubview(emptyImageView)
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
            let index = MobileSegmentOption.init(rawValue: segmentIndex) ?? MobileSegmentOption.All
            self?.handleSegmentSelection(index)
        }
    }
    
    // handle the segment change
    func handleSegmentSelection(_ index: MobileSegmentOption) {
        /// Reload Collection View with selected modules type
        collectionView.reloadData()
        if index == .All {
            if mobiles.count > 0 {
                collectionView.isHidden = false
                emptyImageView.isHidden = true
            } else {
                collectionView.isHidden = true
                emptyImageView.isHidden = false
            }
        } else {
            if favourVm.mobiles.count > 0 {
                collectionView.isHidden = false
                emptyImageView.isHidden = true
            } else {
                collectionView.isHidden = true
                emptyImageView.isHidden = false
            }
        }
    }

    
    /// calling fetch api from viewmodel
    func fetchingMobiles() {
        viewModel.getAllMobiles() { [weak self] mobiles, error in
            self?.mobiles = mobiles ?? []
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        favourVm.getFavouriteMobile()
    }
    
    // MARK: handle actions
    
    /// sorting action on tap of specific sorts
    @objc func sortButtonAction() {
        /// create the alert
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: UIAlertController.Style.alert)
        
        /// add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Price low to high", style: UIAlertAction.Style.default, handler: { [weak self] action in
            self?.filterData(index: 0)
        }))
        alert.addAction(UIAlertAction(title: "Price high to low", style: UIAlertAction.Style.default, handler: { [weak self] action in
            self?.filterData(index: 1)
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: UIAlertAction.Style.default, handler: { [weak self] action in
            self?.filterData(index: 2)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        /// show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    /// filter data on select of specific sort from sort alert popup
    func filterData(index: Int) {
        switch index {
        case 0:
            mobiles.sort(by: { $0.price ?? 0 > $1.price ?? 0})
        case 1:
            mobiles.sort(by: { $0.price ?? 0 < $1.price ?? 0})
        case 2:
            mobiles.sort(by: { $0.rating ?? 0 > $1.rating ?? 0})
        default:
            break
        }
        collectionView.reloadData()
    }
}

// MARK:- Extension for collectionview methods
/// CollectionView delegate & datasource methods.

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            return mobiles.count
        } else {
            return favourVm.mobiles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionViewCell.reuseIdentifier, for: indexPath) as? AllCollectionViewCell else {
                fatalError("Could not dequeue AllCollectionViewCell")
            }
            cell.configure(mobile: mobiles[indexPath.row], index: MobileSegmentOption.All.rawValue)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionViewCell.reuseIdentifier, for: indexPath) as? AllCollectionViewCell else {
                fatalError("Could not dequeue AllCollectionViewCell")
            }
            cell.configure(mobile: favourVm.mobiles[indexPath.row], index: MobileSegmentOption.Favourite.rawValue)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 30
        return CGSize(width: width, height: 130)
    }
    
    
}

