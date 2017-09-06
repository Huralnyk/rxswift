//
//  ViewController.swift
//  BindTableViews
//
//  Created by aleksey on 9/6/17.
//  Copyright © 2017 Oleksii Huralnyk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    let data = Observable.just([
        Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher"),
        Contributor(name: "Yury Korolev", gitHubID: "yury"),
        Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
        Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
        Contributor(name: "Junior B.", gitHubID: "bontoJR"),
        Contributor(name: "Yoshinori Sano", gitHubID: "yoshinorisano"),
        Contributor(name: "Serg Dort", gitHubID: "sergdort"),
        Contributor(name: "Jesse Farless", gitHubID: "solidcell"),
        Contributor(name: "Thane Gill", gitHubID: "thanegill"),
        Contributor(name: "Gleb Vodovozov", gitHubID: "vodovozovge")
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, contributor, cell in
            cell.textLabel?.text = contributor.name
            cell.detailTextLabel?.text = contributor.gitHubID
            cell.imageView?.image = contributor.image
        }.addDisposableTo(disposeBag)
        
        tableView.rx
            .modelSelected(Contributor.self)
            .subscribe(onNext: {
                print("You selected: \($0)")
            }).addDisposableTo(disposeBag)
    }
    
}
