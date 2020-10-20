//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var repeatPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Sign in authentication

    @IBAction func registerPressed(_ sender: AnyObject) {
        
        let error = validateFields()
        
        SVProgressHUD.show()
        
        
        if error != nil {
            
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else {
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                var errorType: String = ""
                
                if error != nil {
                    let errorValue = error! as NSError
                    switch errorValue.code {
                    case AuthErrorCode.wrongPassword.rawValue:
                        errorType = "wrong password"
                    case AuthErrorCode.invalidEmail.rawValue:
                        errorType = "invalid email"
                    case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                        errorType = "accountExistsWithDifferentCredential"
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        errorType = "email is alreay in use"
                    default:
                        errorType = "unknown error: \(errorValue.localizedDescription)"
                    }
                    
                    let alert = UIAlertController(title: "Error", message: errorType, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else {
                    SVProgressHUD.dismiss()
                    print("Registration successful!")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
            
        }
        
    } 
    
    //MARK: - Validate text fields email & password
    
    func validateFields() -> String? {
        
        guard emailTextfield.text?.count != 0 ||
            repeatPasswordTextfield.text?.count != 0 ||
            passwordTextfield.text?.count != 0 else {
                return "Please fill in all fields."
        }
        
        guard (passwordTextfield.text != repeatPasswordTextfield.text) || passwordTextfield.text!.count >= 6  else {
            return "Please make sure your password is at least 6 characters and match to repeat password field"
        }
        
        guard isValidEmail(email: emailTextfield.text ?? "") == false else {
            return "Invalid email"
        }
        
        return nil
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
