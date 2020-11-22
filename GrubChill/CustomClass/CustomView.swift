//
//  CustomView.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import Foundation
import UIKit

class CustomView : UIView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = layer.frame.height / 2
        }
    }
    
}
