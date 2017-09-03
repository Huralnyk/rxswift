//: [Previous](@previous)

import RxSwift

exampleOf(description: "startWith") { 
    let disposeBag = DisposeBag()
    Observable.of("1", "2", "3")
        .startWith("A")
        .startWith("B")
        .startWith("C", "D")
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

exampleOf(description: "merge") { 
    let disposeBag = DisposeBag()
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1, subject2)
        .merge()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    subject1.onNext("A")
    subject1.onNext("B")
    
    subject2.onNext("1")
    subject2.onNext("2")
    
    subject1.onNext("C")
    subject2.onNext("3")
}

exampleOf(description: "zip") { 
    let disposeBag = DisposeBag()
    let stringSubject = PublishSubject<String>()
    let intSubject = PublishSubject<Int>()
    
    Observable.zip(stringSubject, intSubject) { "\($0) \($1)" }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    stringSubject.onNext("A")
    stringSubject.onNext("B")
    
    intSubject.onNext(1)
    intSubject.onNext(2)
    intSubject.onNext(3)
    intSubject.onNext(4)
    
    stringSubject.onNext("B")
}

//: [Next](@next)
