//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import RxSwift

exampleOf(description: "just") {
    let observable = Observable.just("Hello, world!")
    
    observable.subscribe { (event: Event<String>) in
        print(event)
    }
}

exampleOf(description: "of") { 
    let observable = Observable.of(1, 2, 3)
    
    observable.subscribe {
        print($0)
    }
    
    observable.subscribe {
        print($0)
    }
}

exampleOf(description: "from") {
    let disposeBag = DisposeBag()
    
    Observable.from([1, 2, 3]).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    Observable.from([4, 5, 6]).subscribe(onCompleted: {
        print("completed")
    }).addDisposableTo(disposeBag)
}

exampleOf(description: "error") {
    enum Error: Swift.Error {
        case dummy
    }
    
    Observable<Int>.error(Error.dummy).subscribe(onError: {
        print($0)
    })
}
