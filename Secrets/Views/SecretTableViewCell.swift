//
//  SecretTableViewCell.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Parse

class SecretTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var heartsButton: UIButton!
    
    var secret: Secret?
    
    let heartIcon = String.fontAwesomeIconWithName(.Heart)
    var heartsString: String {
        if let hearts = secret?.hearts {
            if hearts > 0 {
                return "\(secret!.hearts) \(heartIcon)"
            }
        }
        return heartIcon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heartsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(15)
        heartsButton.titleLabel?.text = nil
    }
    
    func configureWithSecret(newSecret: Secret) {
        secret = newSecret
        updateUI()
    }
    
    func updateUI() {
        bodyTextView.text = secret?.body
        createdAtLabel.text = secret?.createdAt?.timeAgo()
        
        heartsButton.setTitle(heartsString, forState: UIControlState.Normal)
    }
    
    @IBAction func heartSecret() {
        secret?.addHeart()
        secret?.saveEventually()
        updateUI()
    }
}
