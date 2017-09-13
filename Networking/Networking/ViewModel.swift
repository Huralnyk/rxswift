//
//  ViewModel.swift
//  Networking
//
//  Created by Scott Gardner on 6/6/16.
//  Copyright © 2016 Scott Gardner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let searchText = Variable("")
    let disposeBag = DisposeBag()
    
    lazy var data: Driver<[Repository]> = {
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                self.getRepositories(gitHubID: $0)
            }.asDriver(onErrorJustReturn: [])
    }()
    
    func getRepositories(gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(gitHubID)/repos") else {
                return Observable.just([])
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.json(request: request)
            .retry(3)
//            .catchErrorJustReturn([])
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map {
                var repositories: [Repository] = []
                if let items = $0 as? [[String: AnyObject]] {
                    items.forEach {
                        guard let name = $0["name"] as? String,
                            let url = $0["html_url"] as? String else {
                                return
                            }
                        let repository = Repository(name: name, url: url)
                        repositories.append(repository)
                    }
                }
                return repositories
            }
    }
        
        
}
