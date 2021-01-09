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

class MainBG : UIView {
    @IBInspectable var dropShadow: Bool = false {
        didSet {
            layer.backgroundColor = UIColor(red: 0xd7/255, green: 0x41/255, blue: 0x47/255, alpha: 1.0).cgColor
            
            if dropShadow{
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 3)
                layer.shadowRadius = 1
                layer.shadowOpacity = 0.2
                layer.shouldRasterize = true
                layer.rasterizationScale = dropShadow ? UIScreen.main.scale : 1
                
            }
        }
    }
}


class QuantityButtonView : UIView {
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.shadowColor = UIColor.black.cgColor
            layer.borderColor = UIColor(red: 0xd7/255, green: 0x41/255, blue: 0x47/255, alpha: 1.0).cgColor
            layer.borderWidth = 1
            layer.cornerRadius = cornerRadius
        }
    }
}

@IBDesignable
class TextBoxView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor? = UIColor.lightGray
    override func layoutSubviews() {
        layer.borderColor = borderColor?.cgColor ?? UIColor.lightGray.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
}
