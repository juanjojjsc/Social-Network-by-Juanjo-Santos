//
//  StylishTextField.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/8/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class StylishTextField: UITextField {

    
    
    
    override func awakeFromNib() {
        
        //Corner Radius
        layer.cornerRadius = 2.0
        //Border color
        layer.borderColor = UIColor(colorLiteralRed: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
        
       
        
    }
    
    //Padding for the text 10 to right
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    

}
