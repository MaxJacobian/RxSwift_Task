//
//  FourthViewController.swift
//  HW_3
//
//  Created by Максим Нечеперунко on 12.02.2021.
//

import UIKit
import RxSwift
import RxCocoa



class FourthViewController: UIViewController {
    
    
    
    @IBOutlet var plusCounter: UIButton!
    
    @IBOutlet weak var counter: UILabel!
    
    
    let dispose = DisposeBag()
    
    
    var c = BehaviorSubject(value: 0)
    
    override func viewDidLoad() {
        
        
        
        
        
        plusCounter.rx.tap
            .subscribe(onNext: {
                [self] in c.onNext(try! c.value() + 1)
            }).disposed(by: dispose)
        
        c.bind(with: counter, onNext: { [self]_,el in
            counter.text = "\(el)"
        }).disposed(by: dispose)
              
     
    }
    

}
