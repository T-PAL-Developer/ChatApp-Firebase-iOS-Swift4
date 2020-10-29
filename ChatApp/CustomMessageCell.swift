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
    @IBOutlet var myAvatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.layoutIfNeeded()
        
        messageBackground.layer.cornerRadius = messageBackground.frame.size.height / 5
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        myAvatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        myAvatarImageView.contentMode = .scaleAspectFill
        myAvatarImageView.clipsToBounds = true
       
    }


}
