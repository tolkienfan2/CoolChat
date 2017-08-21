//
//  RoundedButton.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-21.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 7.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }

    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
}
