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
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        
    }
    
    override func drawRect(rect: CGRect) {
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
        
        postImage.clipsToBounds = true
    }

    
    
    // SUPERIMPORTANTE QUE HAGAMOS LA CONFIGURACION DE LA CELDA AQUI!!!! Y NO EN CELLFORROWATINDEXPATH
    
    func configureCell(recievedPost: Post) {
        
        self.post = recievedPost
        
        self.descriptionText.text = post.postDescription
        
        self.likesLbl.text = "\(post.likes)"
        
        
        
        
        
    }
    
    

}
