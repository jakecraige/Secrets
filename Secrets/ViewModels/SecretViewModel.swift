//
//  SecretViewModel.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

class SecretViewModel {
    let secret: Secret
    
    init(secret _secret: Secret) {
        secret = _secret
    }
    
    let heartIcon = String.fontAwesomeIconWithName(.Heart)
    var heartsString: String {
        if secret.hearts > 0 {
            return "\(secret.hearts) \(heartIcon)"
        }
        return heartIcon
    }
    
    var createdTimeAgo: String? {
        return secret.createdAt?.timeAgo()
    }
    
    var body: String? {
        return secret.body
    }
    
}