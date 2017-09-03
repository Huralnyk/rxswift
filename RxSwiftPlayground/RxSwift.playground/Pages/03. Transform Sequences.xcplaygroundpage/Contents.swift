//: [Previous](@previous)

import RxSwift

exampleOf(description: "map") { 
    Observable.of(1, 2, 3).map { $0 * $0 }
        .subscribe(onNext: { print($0)} )
        .dispose()
}

exampleOf(description: "flatMap & flatMapLatest") {
    let disposeBag = DisposeBag()
    
    struct Player {
        let score: Variable<Int>
    }
    
    let scott = Player(score: Variable(80))
    let lori = Player(score: Variable(90))
    var player = Variable(scott)
    
    player.asObservable()
        .flatMapLatest { $0.score.asObservable() }
        .subscribe(onNext: { print($0)} )
        .addDisposableTo(disposeBag)
    
    player.value.score.value = 88
    scott.score.value = 90
    
    player.value = lori
    scott.score.value = 95
    
    lori.score.value = 100
}

exampleOf(description: "scan") {
    let disposeBag = DisposeBag()
    let dartScore = PublishSubject<Int>()
    
    dartScore.asObservable().buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance)
        .map { $0.reduce(0, +) }
        .scan(501, accumulator: { intermediate, newValue in
        let result = intermediate - newValue
        return result == 0 || result > 1 ? result : intermediate
    }).do(onNext: {
        if $0 == 0 {
            dartScore.onCompleted()
        }
    }).subscribe {
        print($0.isStopEvent ? $0 : $0.element!)
    }.addDisposableTo(disposeBag)
    
    dartScore.onNext(13)
    dartScore.onNext(60)
    dartScore.onNext(50)
    dartScore.onNext(0)
    dartScore.onNext(0)
    dartScore.onNext(378)
    
}

//: [Next](@next)
