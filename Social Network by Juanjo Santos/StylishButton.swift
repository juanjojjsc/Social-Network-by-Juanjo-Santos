//
//  StylishButton.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/8/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class StylishButton: UIButton {

    
    override func awakeFromNib() {
        //Set SHADOWS
        layer.shadowColor = UIColor(colorLiteralRed: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        // shadow on right     on left
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
        
        //ROUND CORNERS
        layer.cornerRadius = 5.0
    }
    
    
    

}
