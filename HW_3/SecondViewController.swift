//
//  SecondViewController.swift
//  HW_3
//
//  Created by Максим Нечеперунко on 12.02.2021.
//

import UIKit
import RxSwift
import RxCocoa



class SecondViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        

        searchText.rx.text
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter{$0!.count > 0}
            .subscribe(onNext: {print("Отправка запроса для \(String(describing: $0))")}).disposed(by: disposeBag)
        
    }
    

}
