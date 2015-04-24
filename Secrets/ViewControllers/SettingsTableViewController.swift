//
//  SettingsTableViewController.swift
//  Secrets
//
//  Created by James Craige on 4/24/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBAction func dismiss(sender: UIBarButtonItem?) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    private struct Constants {
        static let SignOutRow = 0
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == Constants.SignOutRow {
            signOutCurrentUser()
        }
    }

    func signOutCurrentUser() {
        UserAuthenticator.signOut()
        let sb = UIStoryboard(name: "Authentication", bundle: NSBundle.mainBundle())
        if let vc = sb.instantiateInitialViewController() as? UINavigationController {
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}
