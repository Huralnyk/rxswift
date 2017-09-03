//: [Previous](@previous)

import RxSwift

exampleOf(description: "PublishSubject") {
    
    enum Error: Swift.Error {
        case dummy
    }
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    
    subject.subscribe() {
        print($0)
    }.addDisposableTo(disposeBag)
    
    subject.on(.next("Hello"))
//    subject.onCompleted()
//    subject.onError(Error.dummy)
    subject.onNext("World")
    
    let newSubscription = subject.subscribe(onNext: {
        print("New subscription:", $0)
    })
    
    subject.onNext("What's up?")
    newSubscription.dispose()
    
    subject.onNext("Still there?")
}

exampleOf(description: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "a")
    
    let firstSubcription = subject.subscribe(onNext: {
        print(#line, $0)
    })
    
    subject.onNext("b")
    
    let secondSubscription = subject.subscribe(onNext: {
        print(#line, $0)
    })
    
    firstSubcription.dispose()
    secondSubscription.dispose()
}

exampleOf(description: "ReplaySubject") {
    let disposeBag = DisposeBag()
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    
    subject.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

exampleOf(description: "Variable") {
    let disposeBag = DisposeBag()
    let variable = Variable("A")
    
    variable.asObservable().subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
    
    variable.value = "B" 
}

//: [Next](@next)
