//
//  WelcomeViewController.swift
//  ChatApp
//
//  Created by Tomasz Paluszkiewicz on 19/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//
import UIKit



class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelAnimation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func tapGestureOnImageView(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.logoLabel.transform = CGAffineTransform(translationX: self.logoLabel.bounds.origin.x, y: self.logoLabel.bounds.origin.y + 50)
            
        }) { (_) in
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                self.logoLabel.isHidden = false
                self.logoLabel.transform = .identity
            }, completion: nil)
        }
    }
    
    
    
    func labelAnimation() {
        
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
        logoLabel.isHidden = true
        
        
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.lbl1.transform = CGAffineTransform(translationX: self.lbl1.bounds.origin.x, y: self.lbl1.bounds.origin.y + 100)
            self.lbl2.transform = CGAffineTransform(translationX: self.lbl2.bounds.origin.x, y: self.lbl2.bounds.origin.y + 100)
            self.lbl3.transform = CGAffineTransform(translationX: self.lbl3.bounds.origin.x, y: self.lbl3.bounds.origin.y + 100)
            self.logoLabel.transform = CGAffineTransform(translationX: self.logoLabel.bounds.origin.x, y: self.logoLabel.bounds.origin.y + 50)
            
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.lbl1.isHidden = false
                self.lbl1.transform = .identity
            }, completion: { (_) in
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                    self.lbl2.isHidden = false
                    self.lbl2.transform = .identity
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                        self.lbl3.isHidden = false
                        self.lbl3.transform = .identity
                    }, completion: { (_) in
                        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                            self.logoLabel.isHidden = false
                            self.logoLabel.transform = .identity
                        }, completion: nil)
                    })
                })
            })
        }
        
    }
    
    
}
