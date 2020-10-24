//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//


import UIKit


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


