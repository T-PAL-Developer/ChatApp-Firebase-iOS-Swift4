//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//


import UIKit
import Firebase


class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontsColor()
        loginButton.layer.cornerRadius = 5
        facebookButton.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func facebookButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Facebook authentication", message: "This allows the app to share information about you", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in
            
            print("facebookButtonTest")
            self.performSegue(withIdentifier: "goToChat", sender: self)
            
        })
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                
                var errorType: String = ""
                
                let errorValue = error! as NSError
                switch errorValue.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    errorType = "wrong password"
                case AuthErrorCode.userNotFound.rawValue:
                    errorType = "user not found"
                default:
                    errorType = "Error: \(errorValue.localizedDescription)"
                }
                
                let alert = UIAlertController(title: "Error", message: errorType, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
                
            } else {
                
                print("Log in successful")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                
            }
            
        }
        
    }
    
    
    
    // MARK: - Fonts color
    
    func fontsColor(){
        
        let attrs1 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "F9AF3B")]
        let attrs2 = [NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "FF57C5")]
        //let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "F9AF3B")]
        
        let attributedString1 = NSMutableAttributedString(string:"Welcome", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:" back", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.label1.attributedText = attributedString1
        
    }
    
}


