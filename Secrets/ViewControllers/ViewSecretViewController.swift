//
//  ViewSecretViewController.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class ViewSecretViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var heartsButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: SecretViewModel?
    
    func setupWithSecret(secret: Secret) {
        viewModel = SecretViewModel(secret: secret)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(15)
        heartsButton.titleLabel?.text = nil
        updateUI()
    }
    
    func updateUI() {
        textView.text = viewModel?.body
        timeAgoLabel.text = viewModel?.createdTimeAgo
        heartsButton.setTitle(viewModel?.heartsString, forState: UIControlState.Normal)
    }
    
    @IBAction func addHeart(sender: UIButton) {
        viewModel?.secret.addHeart()
        viewModel?.secret.saveEventually()
        updateUI()
    }
}
