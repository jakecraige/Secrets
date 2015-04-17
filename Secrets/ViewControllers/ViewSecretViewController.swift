//
//  ViewSecretViewController.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class ViewSecretViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SecretViewModel?
    
    func setupWithSecret(secret: Secret) {
        viewModel = SecretViewModel(secret: secret)
    }
    
    struct Constants {
        static let SecretCellIdentifier = "Secret Cell"
        static let CommentCellIdentifier = "Comment Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "SecretTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: Constants.SecretCellIdentifier)
    }
    
    let comments = [
        ["body": "Something"]
    ]
    
    // MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SecretCellIdentifier) as! SecretTableViewCell
            cell.userInteractionEnabled = false
            if let secret = viewModel?.secret {
                cell.configureWithSecret(viewModel!.secret)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CommentCellIdentifier) as! CommentTableViewCell
            return cell
        }
    }
}
