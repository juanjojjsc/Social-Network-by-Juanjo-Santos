//
//  StylishPostTableViewCell.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/9/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class StylishPostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        
    }
    
    override func drawRect(rect: CGRect) {
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
