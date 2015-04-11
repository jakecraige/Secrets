//
//  SecretsTableViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Parse

class SecretsTableViewController: UITableViewController {
    var secrets: [Secret] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private struct SB {
        static let cellIdentifier = "SecretCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "loadSecrets", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadSecrets()
    }
    
    func loadSecrets() {
        refreshControl?.beginRefreshing()
        Secret.find() { result in
            switch result {
            case .Success:
                self.secrets = result.value!
            case .Failure: UIAlertView(title: "Error", message: "error", delegate: nil, cancelButtonTitle: "OK")
            default: break
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func signOutTapped(sender: UIBarButtonItem) {
        UserAuthenticator.signOut()
        let sb = UIStoryboard(name: "Authentication", bundle: NSBundle.mainBundle())
        if let vc = sb.instantiateInitialViewController() as? UINavigationController {
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: TableViewDataSourceDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secrets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SB.cellIdentifier) as! SecretTableViewCell
        let secret = secrets[indexPath.row]
        cell.configureWithSecret(secret)
        return cell
    }
    
    
}
