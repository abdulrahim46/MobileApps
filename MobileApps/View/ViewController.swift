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
    @IBOutlet weak var tableView: UITableView!
    
    private var emptyImageView = UIImageView()
    private var noDataLabel = UILabel()
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .gray)
    
    let viewModel = AllMobileViewModel()
    let favourVm = FavouriteViewModel()
    
    //MARK: LifeCycles methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityLoader()
        addNavigationItem()
        setupSegmentio()
        setupTableView()
        setupEmptyView()
        fetchingMobiles()
    }
    
    //MARK: Setting the views
    /// navigation right button setup
    func addNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sort",
            style: .plain,
            target: self,
            action: #selector(sortButtonAction)
        )
    }
    
    /// setup Tableview
    func setupTableView() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isHidden = true
        //tableView.allowsSelection = false
        /// Assigning data source and background color
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        tableView.register(UINib(nibName: "AllTableViewCell", bundle: nil), forCellReuseIdentifier: AllTableViewCell.reuseIdentifier)
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
    
    func setupActivityLoader() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
        tableView.reloadData()
        if index == .All {
            if viewModel.mobiles.count > 0 {
                tableView.isHidden = false
                emptyImageView.isHidden = true
            } else {
                tableView.isHidden = true
                emptyImageView.isHidden = false
            }
        } else {
            if favourVm.mobiles.count > 0 {
                tableView.isHidden = false
                emptyImageView.isHidden = true
            } else {
                tableView.isHidden = true
                emptyImageView.isHidden = false
            }
        }
    }
    
    
    /// calling fetch api from viewmodel
    func fetchingMobiles() {
        viewModel.getAllMobiles() { [weak self] mobiles, error in
           // self?.mobiles = mobiles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                self?.loadingIndicator.stopAnimating()
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
        DispatchQueue.main.async { [weak self]  in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    /// filter data on select of specific sort from sort alert popup
    func filterData(index: Int) {
        switch index {
        case 0:
            viewModel.mobiles.sort(by: { $0.price ?? 0 < $1.price ?? 0 })
            favourVm.mobiles.sort(by: { $0.price ?? 0 < $1.price ?? 0 })
        case 1:
            viewModel.mobiles.sort(by: { $0.price ?? 0 > $1.price ?? 0 })
            favourVm.mobiles.sort(by: { $0.price ?? 0 > $1.price ?? 0 })
        case 2:
            viewModel.mobiles.sort(by: { $0.rating ?? 0 > $1.rating ?? 0 })
            favourVm.mobiles.sort(by: { $0.rating ?? 0 > $1.rating ?? 0 })
        default:
            break
        }
        DispatchQueue.main.async { [weak self]  in
            self?.tableView.reloadData()
        }
    }
    
    func navigateToDetailView(mobile: Mobile) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.mobile = mobile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        //print("release everything123")
    }
}

// MARK:- Extension for collectionview methods
/// CollectionView delegate & datasource methods.

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            return viewModel.mobiles.count
        } else {
            return favourVm.mobiles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTableViewCell.reuseIdentifier, for: indexPath) as? AllTableViewCell else {
                fatalError("Could not dequeue AllCollectionViewCell")
            }
            cell.configure(mobile: viewModel.mobiles[indexPath.row], index: MobileSegmentOption.All.rawValue)
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTableViewCell.reuseIdentifier, for: indexPath) as? AllTableViewCell else {
                fatalError("Could not dequeue AllCollectionViewCell")
            }
            cell.configure(mobile: favourVm.mobiles[indexPath.row], index: MobileSegmentOption.Favourite.rawValue)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            let mobile = viewModel.mobiles[indexPath.row]
            navigateToDetailView(mobile: mobile)
        } else {
            let mobile = favourVm.mobiles[indexPath.row]
            navigateToDetailView(mobile: mobile)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if segmentView.selectedSegmentioIndex == MobileSegmentOption.All.rawValue {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { [weak self] _, indexpath in
            
            self?.favourVm.removeFavouriteMobile(mobile: self?.favourVm.mobiles[indexPath.row])
            self?.favourVm.mobiles.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        })
        return [deleteAction]
    }
}

