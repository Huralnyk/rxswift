//
//  ViewController.swift
//  Networking
//
//  Created by Scott Gardner on 6/9/16.
//  Copyright © 2016 Scott Gardner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }
            .addDisposableTo(disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .map { "" }
            .bind(to: viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        viewModel.data.asDriver()
            .map { "\($0.count) Repositories"}
            .drive(navigationItem.rx.title)
            .addDisposableTo(disposeBag)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "scotteg"
        searchBar.placeholder = "Enter GitHub ID, e.g., \"scotteg\""
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
