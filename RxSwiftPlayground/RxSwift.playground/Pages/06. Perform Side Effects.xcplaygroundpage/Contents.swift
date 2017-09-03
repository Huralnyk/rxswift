//: [Previous](@previous)

import RxSwift

exampleOf(description: "doOnNext") {
    let disposeBag = DisposeBag()
    let fahrenheintTemps = Observable.from([-40, 0, 32, 70, 212, 451])
    
    fahrenheintTemps.do(onNext: {
        $0 * $0
    }).do(onNext: {
        print("\($0)℉ = ", terminator: "")
    }).map {
        Double($0 - 32) * 5.0/9.0
    }.subscribe(onNext: {
        print(String(format: "%.1f℃", $0))
    }).addDisposableTo(disposeBag)
}



//: [Next](@next)
