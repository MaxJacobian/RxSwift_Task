//
//  ThirdViewController.swift
//  HW_3
//
//  Created by Максим Нечеперунко on 12.02.2021.
//

import UIKit
import RxSwift
import RxCocoa


class ThirdViewController: UIViewController {
    
    let names = BehaviorSubject(value: ["Max","John","Bruce","Andrew","Gareth","Linda","Bella","Eduard","Ben","Peter","Erick","Stan","Kyle","Kenny","Connor","Cristiano","Killian","Marco","Mario","Robert"])
    var name = ["Max","John","Bruce","Andrew","Gareth","Linda","Bella","Eduard","Ben","Peter","Erick","Stan","Kyle","Kenny","Connor","Cristiano","Killian","Marco","Mario","Robert"]
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var search: UITextField!
    
    @IBOutlet var minus: UIButton!
    
    @IBOutlet var plus: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names.bind(to: tableView.rx.items(cellIdentifier: "Cell")){
            row,name,cell in
            cell.textLabel?.text = name
        }.disposed(by: disposeBag)
        
        
        
        
        search.rx.text
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: {text in
                if let text = text {
                    let arr = self.sortWithText(array: try! self.names.value(), text: text)
                    self.names.onNext(arr)
                    if text.isEmpty || text == ""{
                        self.names.onNext(self.name)
                    }
                   
                }
            }).disposed(by: disposeBag)
        
        plus.rx.tap.subscribe(onNext: {
            [self] in names.onNext(try! [name.randomElement()!] + names.value())
        }).disposed(by: disposeBag)
        minus.rx.tap.subscribe(onNext: {
            [self] in
            var arr = try! names.value()
            arr.remove(at: arr.count - 1)
            names.onNext(arr)
        } ).disposed(by: disposeBag)
    }
    
    func sortWithText(array: [String], text: String)-> [String]{
        var arr: [String] = []
        for element in array {
            if element.contains(text){arr.append(element)}
        }
        return arr
    }
    
}
