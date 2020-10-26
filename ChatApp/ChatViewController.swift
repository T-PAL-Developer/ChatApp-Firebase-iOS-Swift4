//
//  ViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {
    

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        
    }


    
    //MARK: - TableView DataSource Methods
    
    
    

    
    //MARK:- TextField Delegate Methods
    
    

    
  
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
    
        
    }
    
  
    
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do {
            print("Log out success")
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print(error)
            let alert = UIAlertController(title: "Error", message: "Log out problem", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    


}
