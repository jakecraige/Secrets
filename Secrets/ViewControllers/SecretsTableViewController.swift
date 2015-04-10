//
//  SecretsTableViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SecretsTableViewController: UITableViewController {
    @IBAction func signOutTapped(sender: UIBarButtonItem) {
        UserAuthenticator.signOut()
        let sb = UIStoryboard(name: "Authentication", bundle: NSBundle.mainBundle())
        if let vc = sb.instantiateInitialViewController() as? UINavigationController {
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}
