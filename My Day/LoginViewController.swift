//
//  LoginViewController.swift
//  goodApp
//
//  Created by Yu Shih-hao on 2019/7/11.
//  Copyright © 2019 Yu Shih-hao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var pwdTxt: UITextField!
    
    override func viewDidLoad() {
        
        emailTxt.becomeFirstResponder()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginToRestaurants")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
    }
    //鍵盤退出
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func loginAction(_ sender: Any) { //登入
        if (self.emailTxt.text! == "") {
            let alert = UIAlertController(title: "Error", message: "請輸入Ｅmail", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "登入錯誤", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        if (self.pwdTxt.text! == "") {
            let alert = UIAlertController(title: "Error", message: "請輸入密碼", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "登入錯誤", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            Auth.auth().signIn(withEmail: self.emailTxt.text!, password: self.pwdTxt.text!) { (user, error) in
                if (error != nil) {
                    let alert = UIAlertController(title: "登入錯誤", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "登入錯誤", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginToRestaurants")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let signUpAlert = UIAlertController(title: "註冊", message: "註冊", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "儲存", style: .default) { (action) in
            let emailSignUpTextField = signUpAlert.textFields![0]
            let passwordSignUpTextField = signUpAlert.textFields![1]
            Auth.auth().createUser(withEmail: emailSignUpTextField.text!, password: passwordSignUpTextField.text!, completion: { (user, error) in
                if error == nil {
                    let alert = UIAlertController(title: "註冊", message: "註冊成功", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    Auth.auth().signIn(withEmail: emailSignUpTextField.text!, password: passwordSignUpTextField.text!, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        signUpAlert.addTextField { (emailSignUpTextField) in
            emailSignUpTextField.placeholder = "請輸入Email"
        }
        signUpAlert.addTextField { (passwordSignUpTextField) in
            passwordSignUpTextField.placeholder = "請輸入密碼"
            passwordSignUpTextField.isSecureTextEntry = true
        }
        
        signUpAlert.addAction(saveAction)
        signUpAlert.addAction(cancelAction)
        
        present(signUpAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
