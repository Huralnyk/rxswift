//
//  ViewController.swift
//  ForwardDelegates
//
//  Created by aleksey on 9/12/17.
//  Copyright © 2017 Oleksii Huralnyk. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let model = Model()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Contributor>>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.configureCell = { _, tableView, indexPath, contributor in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.imageView?.image = contributor.image
            cell.textLabel?.text = contributor.name
            cell.detailTextLabel?.text = contributor.gitHubID
            return cell
        }
        
        dataSource.titleForHeaderInSection = { data, section in
            data.sectionModels[section].model
        }
        
        model.data
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(96) + 32)
    }
}
