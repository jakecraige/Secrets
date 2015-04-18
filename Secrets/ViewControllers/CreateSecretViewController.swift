//
//  CreateSecretViewController.swift
//  Secrets
//
//  Created by James Craige on 4/10/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class CreateSecretViewController: UIViewController, UITextViewDelegate {
    var secretCreated = { (secret: Secret) -> Void in }
    
    private struct SB {
        struct TextView {
            static let inactiveColor = UIColor.lightGrayColor()
            static let activeColor = UIColor.blackColor()
            static let placeholderText = "Enter your secret here..."
        }
    }
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        placeholderizeTextView(bodyTextView)
        UINavigationBar.appearance().barTintColor = UIColor.redColor()
    }
    
    @IBAction func cancel(sender: UIBarButtonItem?) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createSecret(sender: UIBarButtonItem) {
        Secret.createWithBody(bodyTextView.text).finally { 
            self.cancel(nil)
        }
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == SB.TextView.inactiveColor {
            deplaceholderizeTextView(textView)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            placeholderizeTextView(textView)
        }
    }
    
    func placeholderizeTextView(textView: UITextView) {
        textView.text = SB.TextView.placeholderText
        textView.textColor = SB.TextView.inactiveColor
    }
    
    func deplaceholderizeTextView(textView: UITextView) {
        textView.text = nil
        textView.textColor = SB.TextView.activeColor
    }
}
