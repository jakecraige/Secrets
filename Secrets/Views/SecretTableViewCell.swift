//
//  SecretTableViewCell.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SecretTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var heartsButton: UIButton!
    
    struct Constants {
        static let RowHeight = UITableViewAutomaticDimension
        static let EstimatedRowHeight: CGFloat = 67
    }
    
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
        bodyLabel.text = viewModel?.body
        createdAtLabel.text = viewModel?.createdTimeAgo
        
        heartsButton.setTitle(viewModel?.heartsString, forState: UIControlState.Normal)
    }
    
    @IBAction func heartSecret(sender: UIButton) {
        viewModel?.secret.addHeart()
        viewModel?.secret.saveEventually()
        updateUI()
    }
    
}
