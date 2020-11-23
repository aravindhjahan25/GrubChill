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
            layer.backgroundColor = UIColor(red: 0xd7/255, green: 0x51/255, blue: 0x47/255, alpha: 1.0).cgColor
        }
    }
    
}

class CustomButtonStroke : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = layer.frame.height / 2
            layer.backgroundColor = UIColor.white.cgColor
            layer.borderWidth = 1
            layer.borderColor = UIColor(red: 0xd7/255, green: 0x51/255, blue: 0x47/255, alpha: 1.0).cgColor
        }
    }
    
}


