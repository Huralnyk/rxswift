//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

exampleOf(description: "catchErrorJustReturn") {
    let disposeBag = DisposeBag()
    let sequenceThatFails = PublishSubject<String>()
    
    sequenceThatFails.catchErrorJustReturn("😀")
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    sequenceThatFails.onNext("Hello, world!")
    sequenceThatFails.onError(Error.test)
}

exampleOf(description: "catchError") {
    let disposeBag = DisposeBag()
    let sequenceThatFails = PublishSubject<String>()
    let recoverySequence = PublishSubject<String>()
    
    sequenceThatFails.catchError {
        print("Error:", $0)
        return recoverySequence
    }.subscribe {
        print($0)
    }
    
    sequenceThatFails.onNext("Hello, again")
    sequenceThatFails.onError(Error.test)
    sequenceThatFails.onNext("Still there?")
    
    recoverySequence.onNext("Don't worry, I've got this!")
}

exampleOf(description: "retry") {
    let disposeBag = DisposeBag()
    var count = 1
    
    let sequenceThatErrors = Observable<Int>.create { o in
        o.onNext(1)
        o.onNext(2)
        
        if count < 5 {
            o.onError(Error.test)
            print("Error encountered")
            count += 1
        }
        
        o.onNext(3)
        o.onCompleted()
        
        return Disposables.create()
    }
    
    sequenceThatErrors
        .retry(3)
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}

exampleOf(description: "Driver onErrorJustReturn") {
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<Int>()
    
    subject.asDriver(onErrorJustReturn: 1000)
        .drive(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onError(Error.test)
    subject.onNext(3)
}

exampleOf(description: "Driver onErrorDriveWith") {
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<Int>()
    let recoverySubject = PublishSubject<Int>()
    
    subject.asDriver(onErrorDriveWith: recoverySubject.asDriver(onErrorJustReturn: 1000))
        .drive(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onError(Error.test)
    subject.onNext(3)
    recoverySubject.onNext(4)
}

exampleOf(description: "Driver onErrorRecover") {
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<Int>()
    
    subject
        .asDriver(onErrorRecover: {
            print("Error:", $0)
            return Driver.just(1000)
        }).drive(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onError(Error.test)
    subject.onNext(3)
}

//: [Next](@next)
