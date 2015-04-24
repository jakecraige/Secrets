//
//  SecretsTableViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit

class SecretsTableViewController: UITableViewController {
    var secrets: [Secret] = [] {
        didSet {
            if oldValue.count != secrets.count {
                tableView.reloadData()
            }
        }
    }
    
    private struct Constants {
        static let CellIdentifier = "Secret Cell"
        static let ViewSecretIdentifier = "View Secret"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = SecretTableViewCell.Constants.RowHeight
        tableView.estimatedRowHeight = SecretTableViewCell.Constants.EstimatedRowHeight
        tableView.registerNib(UINib(nibName: "SecretTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: Constants.CellIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refreshSecrets", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadSecrets()
    }

    func refreshSecrets() {
        refreshControl?.beginRefreshing()
        loadSecrets().finally {
            self.refreshControl?.endRefreshing()
        }
    }

    func loadSecrets() -> Promise<Void> {
        return Secret.find().then { (secrets: [Secret]) -> Void in
            self.secrets = secrets
        }.catch { (error: NSError) -> Void in
            UIAlertView(title: "Error", message: "error", delegate: nil, cancelButtonTitle: "OK")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.ViewSecretIdentifier {
            if let vc = segue.destinationViewController as? ViewSecretViewController, indexPath = sender as? NSIndexPath {
                let secret = secrets[indexPath.row]
                vc.setupWithSecret(secret)
            }
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier) as! SecretTableViewCell
        let secret = secrets[indexPath.row]
        cell.configureWithSecret(secret)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Constants.ViewSecretIdentifier, sender: indexPath)
    }
}
