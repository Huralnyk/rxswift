//: [Previous](@previous)

import RxSwift
import PlaygroundSupport

let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
PlaygroundPage.current.liveView = imageView

let swift = #imageLiteral(resourceName: "Swift.png")
let swiftImageData = UIImagePNGRepresentation(swift)!
let rx = #imageLiteral(resourceName: "Rx.png")
let rxImageData = UIImagePNGRepresentation(rx)!

let disposeBag = DisposeBag()
let imageDataSubject = PublishSubject<Data>()

let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)

let myQueue = DispatchQueue(label: "com.huralnyk.myConcurrentQueue", attributes: .concurrent)
let scheduler2 = SerialDispatchQueueScheduler(queue: myQueue, internalSerialQueueName: "com.huralnyk.mySerialQueue")

let operationQueue = OperationQueue()
operationQueue.qualityOfService = .background
let scheduler3 = OperationQueueScheduler(operationQueue: operationQueue)

imageDataSubject
    .observeOn(scheduler3)
    .map { UIImage(data: $0) }
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: {
        imageView.image = $0
    }).addDisposableTo(disposeBag)

imageDataSubject.onNext(swiftImageData)
imageDataSubject.onNext(rxImageData)

//: [Next](@next)
