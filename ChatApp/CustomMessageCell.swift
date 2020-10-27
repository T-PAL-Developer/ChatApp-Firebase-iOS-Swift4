//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Tomasz Paluszkiewicz on 23/10/2020.
//  Copyright © 2020 Tomasz Paluszkiwicz. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {


    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
        
        
    }


}
