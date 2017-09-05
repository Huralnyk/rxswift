//
//  ViewController.swift
//  BindUIElements
//
//  Created by aleksey on 9/5/17.
//  Copyright © 2017 Oleksii Huralnyk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textView: TextView!
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var button: Button!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedControlLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.rx.event
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
//            .bind(onNext: { [unowned self] _ in
//                self.view.endEditing(true)
//            })
            .addDisposableTo(disposeBag)
        
        textField.rx.text.asDriver()
            .drive(textFieldLabel.rx.text)
//            .drive(onNext: { [unowned self] in
//                self.textFieldLabel.rx.text.onNext($0)
//            })
            .addDisposableTo(disposeBag)
        
//        textField.rx.text.bind(to: textFieldLabel.rx.text).addDisposableTo(disposeBag)
        
        textView.rx.text.bind(onNext: { [unowned self] in
            self.textViewLabel.text = "Characters count: \($0?.characters.count ?? 0)"
//            self.textViewLabel.rx.text.onNext("Characters count: \($0?.characters.count ?? 0)")
        }).addDisposableTo(disposeBag)
        
        button.rx.tap.asDriver().drive(onNext: { [unowned self] in
            self.buttonLabel.text! += "Tapped! "
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
        }).addDisposableTo(disposeBag)
        
        segmentedControl.rx.value.asDriver()
            .skip(1)
            .drive(onNext: { [unowned self] in
                self.segmentedControlLabel.text = "Selected segment: \($0)"
                UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
            }).addDisposableTo(disposeBag)
        
        slider.rx.value.asDriver()
            .drive(progressView.rx.progress)
            .addDisposableTo(disposeBag)
        
        aSwitch.rx.value.asDriver()
            .map { !$0 }
            .drive(activityIndicator.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        aSwitch.rx.value.asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .addDisposableTo(disposeBag)
        
        stepper.rx.value.asDriver()
            .map { String(Int($0)) }
            .drive(stepperLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        datePicker.rx.date.asDriver()
            .map { [unowned self] in
                self.dateFormatter.string(from: $0)
            }.drive(onNext: { [unowned self] in
                self.datePickerLabel.text = "Selected date: \($0)"
            }).addDisposableTo(disposeBag)
        
    }

}
