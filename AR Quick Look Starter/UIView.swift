//
//  UIView.swift
//  FS_Project
//
//  Created by Bisan Eisa on 3/16/19.
//  Copyright © 2019 Bisan Eisa. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView{
    
    @IBInspectable
    var cornerRadius : CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor : UIColor? {
        get{
            if let cdColor = layer.borderColor {
                return UIColor(cgColor: cdColor)
            }
            return nil
        }
        set{
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth : CGFloat{
        get{
           return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    
    
}
