//
//  CustomButton.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = layer.frame.height / 2
        }
    }
    
}
