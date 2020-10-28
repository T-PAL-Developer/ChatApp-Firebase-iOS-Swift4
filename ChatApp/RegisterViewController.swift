//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SVProgressHUD

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var avatar: UIButton!
    
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontsColor()
        
        registerButton.layer.cornerRadius = 5
        facebookButton.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupAvatar()
        
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    
    // MARK: - Setup optional user avatar photo
    
    func setupAvatar() {
        
        avatar.layer.cornerRadius = 45
        avatar.imageView?.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func presentPicker() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatar.setImage(imageSelected, for: .normal)
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
              avatar.setImage(imageOriginal, for: .normal)
          }
        
        picker.dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Sign in authentication
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        let error = validateFields()
        
        
        if error != nil {
            
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        else {
            
            guard let imageSelected = self.image else {
                print("Avatar is not selected")
                return
            }
            
            guard let imageData = imageSelected.jpegData(compressionQuality: 0.5) else {
                return
            }
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                if error != nil {
                    
                    var errorType: String = ""
                    
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
                    
                    return
                    
                }
                else {
                    
                    
                    // data configuration
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.userTextfield.text
                    changeRequest?.commitChanges { (error) in
                        if error != nil {
                        print("error changeRequest: \(String(describing: error?.localizedDescription))")
                        return
                        }
                    }
                    
                    let ref = Database.database().reference(withPath: "main/users").child(Auth.auth().currentUser!.uid)
                    ref.setValue(["email": self.emailTextfield.text!,
                                  "user": self.userTextfield.text!,
                                  "creationDate": String(describing: Date()),
                                  "profileImageUrl": ""])
                       
                    // photos storage configration
                    let storageRef = Storage.storage().reference(forURL: "gs://chatapp-tpal.appspot.com")
                    let storageProfileRef = storageRef.child("profile").child("\(Auth.auth().currentUser!.uid)")
                    
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    storageProfileRef.putData(imageData, metadata: metadata) { (storageMetaData, error) in
                        if error != nil {
                          print("error storageProfileRef: \(String(describing: error?.localizedDescription))")
                            return
                        }
                        storageProfileRef.downloadURL { (url, error) in
                            if let metaImageUrl = url?.absoluteString {
                                print(metaImageUrl)
                                Database.database().reference(withPath: "main/users").child("\(Auth.auth().currentUser!.uid)").updateChildValues(["profileImageUrl": metaImageUrl]) { (error, ref) in
                                    if error == nil {
                                        
                                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                        changeRequest?.photoURL = url
                                        changeRequest?.commitChanges { (error) in
                                            if error != nil {
                                            print("error changeRequest URL: \(String(describing: error?.localizedDescription))")
                                            return
                                            }
                                            print("\(String(describing: (Auth.auth().currentUser?.photoURL)!))")
                                        }
                                        print("UpdateChildValues Image URL Done!")
                                    }
                                }
                          
                            }
                        }
                    }
                    
                    
                    
                    print("Registration successful!")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                    
                }
            }
            
        }
        
    } 
    
    //MARK: - Validate text fields email & password
    
    func validateFields() -> String? {
        
        guard userTextfield.text?.count != 0 || emailTextfield.text?.count != 0 ||
            repeatPasswordTextfield.text?.count != 0 ||
            passwordTextfield.text?.count != 0 else {
                return "Please fill all fields"
        }
        
        guard (passwordTextfield.text == repeatPasswordTextfield.text) && passwordTextfield.text!.count >= 6  else {
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


