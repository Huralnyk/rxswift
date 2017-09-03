//: [Previous](@previous)

import RxSwift

exampleOf(description: "filter") { 
    let disposeBag = DisposeBag()
    let numbers = Observable.generate(initialState: 1, condition: { $0 < 101 }, iterate: { $0 + 1 })
    numbers.filter { number in
        guard number > 1 else { return false }
        for i in 2 ..< number {
            if number % i == 0 {
                return false
            }
        }
        return true
    }.toArray()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

exampleOf(description: "distinctUntilChange") { 
    let disposeBag = DisposeBag()
    let searchString = Variable("")
    
    searchString.asObservable().map {
        $0.lowercased()
    }.distinctUntilChanged().subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    searchString.value = "APPLE"
    searchString.value = "apple"
    searchString.value = "banana"
    searchString.value = "apple"
}

exampleOf(description: "takeWhile") { 
    let disposeBag = DisposeBag()
    let numbers =  Observable.from([1, 2, 3, 4, 3, 2, 1])
    
    numbers.takeWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}
//: [Next](@next)
