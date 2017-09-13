//
//  ViewController.swift
//  BindCollectionViews
//
//  Created by aleksey on 9/11/17.
//  Copyright © 2017 Oleksii Huralnyk. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    typealias Item = String
    typealias Identity = String
    var identity: String { return title }
    var items: [String] { return data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    let data = Variable([AnimatedSectionModel(title: "Section: 0", data: ["0-0"])])
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        dataSource.configureCell = { _, collectionView, indexPath, title in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            cell.titleLabel.text = title
            return cell
        }
        
        dataSource.supplementaryViewFactory = { dataSource, collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
            header.titleLabel.text = dataSource.sectionModels[indexPath.section].title
            return header
        }
        
        data.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        addBarButtonItem.rx.tap.asDriver()
            .drive(onNext: { [unowned self] in
                let section = self.data.value.count
                let items: [String] = {
                    var items: [String] = []
                    let random = Int(arc4random_uniform(6)) + 1
                    (0 ... random).forEach {
                        items.append("\(section)-\($0)")
                    }
                    return items
                }()
                self.data.value += [AnimatedSectionModel(title: "Section: \(section)", data: items)]
            }).addDisposableTo(disposeBag)
        
        longPressGestureRecognizer.rx.event
            .subscribe(onNext: { [unowned self] in
                switch $0.state {
                case .began:
                    guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else {
                        break
                    }
                    self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                case .changed:
                    self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: self.collectionView))
                case .ended:
                    self.collectionView.endInteractiveMovement()
                default:
                    self.collectionView.cancelInteractiveMovement()
                }
            }).addDisposableTo(disposeBag)
    }
}
