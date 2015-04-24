//
//  ViewSecretViewController.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Parse

class ViewSecretViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newCommentTextField: UITextField!
    
    var viewModel: SecretViewModel?
    var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func setupWithSecret(secret: Secret) {
        viewModel = SecretViewModel(secret: secret)
    }
    
    struct Constants {
        static let SecretCellIdentifier = "Secret Cell"
        static let CommentCellIdentifier = "Comment Cell"
        static let KeyboardAnimationDuration = 0.3
        static let StaticCellsCount = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "SecretTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: Constants.SecretCellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadComments()
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterForKeyboardNotifications()
    }
    
    func loadComments() {
        Comment.whereSecretIs(viewModel!.secret).then { (comments: [Comment]) -> Void in
            self.comments = comments
        }
    }
    
    func createComment(text: String) {
        Comment.createWithBody(text, secret: viewModel!.secret).then { _ -> Void in
            self.newCommentTextField.text = nil
            self.loadComments()
        }
    }
    
    // MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + Constants.StaticCellsCount
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SecretCellIdentifier) as! SecretTableViewCell
            cell.userInteractionEnabled = false
            cell.configureWithSecret(viewModel!.secret)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CommentCellIdentifier) as! CommentTableViewCell
            cell.configureWithComment(comments[indexPath.row - Constants.StaticCellsCount])
            return cell
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SecretTableViewCell.Constants.EstimatedRowHeight;
        } else {
            return CommentTableViewCell.Constants.EstimatedRowHeight;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return SecretTableViewCell.Constants.RowHeight;
        } else {
            return CommentTableViewCell.Constants.RowHeight;
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dismissKeyboard()
        createComment(textField.text)
        return true
    }
    
    func dismissKeyboard() {
        newCommentTextField.resignFirstResponder()
    }
    
    func animateFrame(distance: CGFloat, up: Bool) {
        let movement = up ? -distance : distance
        
        UIView.animateWithDuration(Constants.KeyboardAnimationDuration, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0.0, movement)
        })
    }
    
    // MARK: KeyboardRelated
    
    var keyboardTapRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    }
    
    func registerForKeyboardNotifications() {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterForKeyboardNotifications() {
        let center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.addGestureRecognizer(keyboardTapRecognizer)
        if let kbSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size {
            animateFrame(kbSize.height, up: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if let kbSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size {
            animateFrame(kbSize.height, up: false)
        }
        view.removeGestureRecognizer(keyboardTapRecognizer)
    }
}
