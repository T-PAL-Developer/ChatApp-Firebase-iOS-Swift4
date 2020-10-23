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
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontsColor()
        
        registerButton.layer.cornerRadius = 5
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Sign in authentication

    @IBAction func registerPressed(_ sender: AnyObject) {
        
        let error = validateFields()
     
        
        
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
        
        guard isValidEmail(email: emailTextfield.text ?? "") != false else {
            return "Invalid email"
        }
        
        return nil
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // MARK: - Fonts color

     func fontsColor(){
         
        
         
        let attrs1 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "F9AF3B")]
         let attrs2 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "FF57C5")]
        let attrs3 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "FF4C0F")]
        let attrs4 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "B6FF8D")]
         //let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]

         let attributedString1 = NSMutableAttributedString(string:"Create", attributes:attrs1)

         let attributedString2 = NSMutableAttributedString(string:" a", attributes:attrs2)
        
        let attributedString3 = NSMutableAttributedString(string:" new", attributes:attrs3)

        let attributedString4 = NSMutableAttributedString(string:" account", attributes:attrs4)
        
        
            
         attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
         self.label1.attributedText = attributedString1
         
     }
    
}
