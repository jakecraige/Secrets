//
//  CommentTableViewCell.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var commentBodyLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    func configureWithComment(comment: Comment?) {
        commentBodyLabel.text = comment?.body
    }
}
