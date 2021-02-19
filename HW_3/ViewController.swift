//
//  ViewController.swift
//  HW_3
//
//  Created by Максим Нечеперунко on 11.02.2021.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet var errorLogin: UILabel!
    
    @IBOutlet var errorPassword: UILabel!
    
    
    
    
   let validateEmail = "gmail.com"
   let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emailValid: Observable<Bool> = emailTextField
            .rx
            .text
            .map{ [self]email -> Bool in  (email?.contains(validateEmail))!}
            
        let passValid: Observable<Bool> = passwordTextField
                    .rx
                    .text
                    .map { pass -> Bool in pass!.count >= 6}

        Observable.combineLatest(emailValid, passValid)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { email, pass in
                if (email, pass) == (true, true) {
                    self.sendButton.isEnabled = true
                    self.sendButton.alpha = 1
    
                } else {
                    self.sendButton.isEnabled = false
                    self.sendButton.alpha = 0.1
               }

               if self.emailTextField.text!.count > 0 && email == false{
                self.errorLogin.text = "некорректная почта"
               } else {
                self.errorLogin.text = ""
               }
               if self.passwordTextField.text!.count > 0 && pass == false {
                self.errorPassword.text = "Слишком короткий пароль"
               } else if self.passwordTextField.text!.count > 6 && email == false {
                self.errorLogin.text = "некорректная почта"
               } else {
                self.errorPassword.text = ""
               }
                 }).disposed(by: disposeBag)
    }
}




