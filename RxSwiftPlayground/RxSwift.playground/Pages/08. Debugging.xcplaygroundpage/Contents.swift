//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

func sampleWithPublish() {
    let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
    
    interval.debug("1st").subscribe { _ in }
    
    delay(seconds: 2) {
        interval.connect()
    }
    
    let disposeBag = DisposeBag()
    delay(seconds: 4) {
        _ = interval.debug("2nd")
            .subscribe { _ in }
            .addDisposableTo(disposeBag)
    }
}

//sampleWithPublish()

exampleOf(description: "resourceCount") {
    print(RxSwift.Resources.total)
    let disposeBag = DisposeBag()
    print(RxSwift.Resources.total)
    let observable = Observable.just("Hello, World!")
    print(RxSwift.Resources.total)
    
    observable.subscribe(onNext: { _ in
        print(RxSwift.Resources.total)
    }).addDisposableTo(disposeBag)
    
    print(RxSwift.Resources.total)
}

print(RxSwift.Resources.total)

//: [Next](@next)
