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
    
    var viewModel: SecretViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heartsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(15)
        heartsButton.titleLabel?.text = nil
    }
    
    func configureWithSecret(secret: Secret) {
        viewModel = SecretViewModel(secret: secret)
        updateUI()
    }
    
    func updateUI() {
        bodyTextView.text = viewModel?.body
        createdAtLabel.text = viewModel?.createdTimeAgo
        
        heartsButton.setTitle(viewModel?.heartsString, forState: UIControlState.Normal)
    }
    
    @IBAction func heartSecret() {
        viewModel?.secret.addHeart()
        viewModel?.secret.saveEventually()
        updateUI()
    }
}
