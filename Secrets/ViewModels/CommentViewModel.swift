//
//  CommentViewModel.swift
//  Secrets
//
//  Created by James Craige on 4/24/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

class CommentViewModel {
    let comment: Comment

    init(comment _comment: Comment) {
        comment = _comment
    }

    var createdTimeAgo: String? {
        return comment.createdAt?.timeAgo()
    }

    var body: String? {
        return comment.body
    }
}