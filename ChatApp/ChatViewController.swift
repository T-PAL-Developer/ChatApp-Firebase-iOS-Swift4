//
//  ViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet var heightTextfieldConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        
        messageTextfield.delegate = self
        
        keyboardConfig()
        
    }
    
    
    
    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let messageArray = ["First Message", "Secondhjghjghjghjghjghjhgjhjghnghnbghnbvhgnbfvhgnvnbv gfvgbfvgf hgb Message", "Third Message"]
        
        cell.messageBody.text = messageArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { tableView.keyboardDismissMode = .onDrag
        return 3
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
    //MARK:- Keyboard Configuration
    
    func keyboardConfig() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
      }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight  = CGFloat(keyboardSize.height)
            
             UIView.animate(withDuration: 0.5) {
                self.heightTextfieldConstraint.constant += keyboardHeight
                       self.view.layoutIfNeeded()
                   }
           
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight  = CGFloat(keyboardSize.height)
            UIView.animate(withDuration: 0.5) {
                self.heightTextfieldConstraint.constant -= keyboardHeight
                      self.view.layoutIfNeeded()
                  }
           
        }
        
    }
    
    
    
    
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
