//
//  Modelable.swift
//  Secrets
//
//  Created by James Craige on 4/17/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Parse

protocol Modelable {
    var object: PFObject { get }
    init(object: PFObject)
}