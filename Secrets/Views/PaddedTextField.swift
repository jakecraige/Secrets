//
//  PaddedTextField.swift
//  Secrets
//
//  Created by James Craige on 4/24/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

@IBDesignable
class PaddedTextField: UITextField {
    @IBInspectable var inset: CGFloat = 0

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
}
