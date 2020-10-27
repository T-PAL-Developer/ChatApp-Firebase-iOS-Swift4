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
        
        retrieveMessagesFromFirebase()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        
        messageTextfield.delegate = self
        
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        keyboardAddObserver()
    //
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        keyboardRemoveObserver()
    //
    //    }
    
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

    
    
    //MARK: - Send & Recieve from Firebase
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        
        let messageDB = Database.database().reference(withPath: "main/users").child("\(Auth.auth().currentUser!.uid)").child("Messages")
        
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.displayName, "MessageBody": messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
            
            if error != nil {
                print(error)
            }
            else {
                print("Message saved successfully!")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
                
            }
            
        }
        
    }
    
    func retrieveMessagesFromFirebase() {
        
        let messageDB = Database.database().reference(withPath: "main/users").child("\(Auth.auth().currentUser!.uid)").child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            print(text, sender)
        }
        
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



//MARK:- TextField Delegate Methods
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
      
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
      
  }
  


//MARK:- Keyboard Configuration
  
  // // NO MORE NEEDED - WE ARE USING HERE A THIRD PARTY LIBRARY IQKeyboardManagerSwift
  
  //    func tapGestureDismissKeyboard() {
  //        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
  //        view.addGestureRecognizer(tap)
  //    }
  //
  //    @objc func dismissKeyboard() {
  //        view.endEditing(true)
  //    }
  //
  //    func keyboardAddObserver() {
  //
  //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
  //
  //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  //    }
  //
  //    func keyboardRemoveObserver() {
  //
  //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
  //
  //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  //    }
  //
  //    @objc func keyboardWillShow(notification: Notification) {
  //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
  //            let keyboardHeight  = CGFloat(keyboardSize.height)
  //            UIView.animate(withDuration: 0.5) {
  //                self.heightTextfieldConstraint.constant += keyboardHeight
  //                self.view.layoutIfNeeded()
  //            }
  //        }
  //
  //    }
  //
  //    @objc func keyboardWillHide(notification: Notification) {
  //
  //        self.heightTextfieldConstraint.constant = 50
  //        self.view.layoutIfNeeded()
  //
  //                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
  //                    let keyboardHeight  = CGFloat(keyboardSize.height)
  //
  //
  //                }
  //
  //    }
  
  
  
  
