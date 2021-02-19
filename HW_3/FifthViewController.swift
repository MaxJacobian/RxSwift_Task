//
//  FifthViewController.swift
//  HW_3
//
//  Created by Максим Нечеперунко on 12.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class FifthViewController: UIViewController {

    @IBOutlet weak var labelField: UILabel!
    
    
    @IBOutlet var first: UIButton!
    
    @IBOutlet var second: UIButton!
    
    
    let dispose = DisposeBag()
    
    var flag1 = BehaviorSubject(value: false)
    var flag2 = BehaviorSubject(value: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first.rx.tap.subscribe(onNext: {
            [self] in flag1.onNext(true)
        }).disposed(by: dispose)
        second.rx.tap.subscribe(onNext: {
            [self] in flag2.onNext(true)
        }).disposed(by: dispose)

        Observable.combineLatest(flag1,flag2){
            $0 && $1
        }
        .subscribe(onNext: {
            [self] in
            if $0 {labelField.text = "Ракета запущена"}
        }).disposed(by: dispose)
        
        
        

    }

    

    


}
