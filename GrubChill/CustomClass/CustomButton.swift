//
//  CustomButton.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import Foundation
import UIKit

@IBDesignable
class CustomButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            self.setTitleColor(UIColor.white, for: .normal)
            layer.cornerRadius = layer.frame.height / 2
            layer.backgroundColor = UIColor(red: 0xd7/255, green: 0x51/255, blue: 0x47/255, alpha: 1.0).cgColor
        }
    }
    
    @IBInspectable var allCaps: Bool = false {
        didSet{
            if allCaps {
                self.setTitle(self.title(for: .normal)?.uppercased(), for: .normal)
            }else{
                self.setTitle(self.title(for: .normal), for: .normal)
            }
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


