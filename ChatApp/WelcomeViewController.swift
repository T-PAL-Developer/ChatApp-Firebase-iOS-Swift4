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
    @IBOutlet weak var lbl4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        labelAnimation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func labelAnimation() {
        
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
//        lbl4.isHidden = true
        logoLabel.isHidden = true
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.lbl1.isHidden = false
            self.lbl1.transform = CGAffineTransform(translationX: 0, y: -236)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.lbl2.isHidden = false
                self.lbl2.transform = CGAffineTransform(translationX: 0, y: -206)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                    self.lbl3.isHidden = false
                    self.lbl3.transform = CGAffineTransform(translationX: -67, y: -46)
                }, completion: { (_) in
                    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                    
                    self.logoLabel.isHidden = false
                    self.logoLabel.transform = CGAffineTransform(translationX: 0, y: -120)
                    }, completion: nil)
                    })
                })
           
        }
        
    }
    
    
}
