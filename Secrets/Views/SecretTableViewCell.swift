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
    
    func configureWithSecret(secret: PFObject) {
        bodyTextView.text = secret["body"] as? String
        let date = NSDateFormatter.localizedStringFromDate(secret.createdAt!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        createdAtLabel.text = date
    }
    
}
