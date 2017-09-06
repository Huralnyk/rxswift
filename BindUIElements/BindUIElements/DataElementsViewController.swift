//
//  DataElementsViewController.swift
//  BindUIElements
//
//  Created by aleksey on 9/6/17.
//  Copyright © 2017 Oleksii Huralnyk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DataElementsViewController: UIViewController {

    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: Button!
    
    let disposeBag = DisposeBag()
    var textFieldText = Variable<String>("")
    var buttonTapped = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.rx.event.asDriver()
            .drive(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            }).addDisposableTo(disposeBag)
        
        textField.rx.text.map { $0 ?? "" }
            .bind(to: textFieldText)
            .addDisposableTo(disposeBag)
        
        textFieldText.asObservable()
            .skip(1)
            .subscribe(onNext: {
                print($0)
            }).addDisposableTo(disposeBag)
        
        button.rx.tap
            .map { "Tapped!" }
            .bind(to: buttonTapped)
            .addDisposableTo(disposeBag)
        
        buttonTapped.asObservable()
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
    }
}
