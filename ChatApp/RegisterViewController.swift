//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit
import Firebase

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
    
    
    
    func validateFields() -> String? {
        
        if  emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            repeatPasswordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        if (passwordTextfield.text != repeatPasswordTextfield.text) || passwordTextfield.text!.count < 8  {
            return "Please make sure your password is at least 8 characters and match to repeat password field"
        }
        
        if isValidEmail(email: emailTextfield.text ?? "") == false {
            return "Invalid email"
        }
        
        return nil
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                
            })
            
            present(alert, animated: true, completion: nil)
        }
        else {
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                var errorType: String = ""
                
                if error != nil {
                    let err = error! as NSError
                    switch err.code {
                    case AuthErrorCode.wrongPassword.rawValue:
                        errorType = "wrong password"
                    case AuthErrorCode.invalidEmail.rawValue:
                        errorType = "invalid email"
                    case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                        errorType = "accountExistsWithDifferentCredential"
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        errorType = "email is alreay in use"
                    default:
                        errorType = "unknown error: \(err.localizedDescription)"
                    }
                    
                    let alert = UIAlertController(title: "Error", message: errorType, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        
                    })
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else {
                    print("Registration successful!")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
            
        }
        
    } 
    
    
}
