//
//  StylishPostTableViewCell.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/9/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit
import Alamofire

class StylishPostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    // request de tipo Firebase. La guardamos para poder cancelarla
    var request: Request?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        
    }
    
    override func drawRect(rect: CGRect) {
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
        
        postImage.clipsToBounds = true
    }

    
    
    // SUPERIMPORTANTE QUE HAGAMOS LA CONFIGURACION DE LA CELDA AQUI!!!! Y NO EN CELLFORROWATINDEXPATH
    
    func configureCell(recievedPost: Post, recievedImg: UIImage?) {
        
        self.post = recievedPost
        
        self.descriptionText.text = post.postDescription
        
        self.likesLbl.text = "\(post.likes)"
        
        
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        //                      DESCARGAMOS LAS IMAGENES AL CACHE QUE ES VOLATIL
        //               ASI SOLO LAS DESCARGAMOS UNA VEZ CADA QUE SE REFRESCA LA TABLA
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        // ---------------------------------------------------------------------------------
        
        
        //Si si recivimos una imagen, poruqe podria ser que no puso imagen el usuario
        if recievedPost.imgUrl != nil {
            //si si hay imagen tenemos que descargarla
            
            //SI RECIBIMOS ALGO, ES PORQUE YA ESTA GUARDADA EN EL CACHE
            if recievedImg != nil {
                
                //LOADEARLA DESDE EL CACHE
                self.postImage.image = recievedImg
            } else {
                
                //Si no recibimos algo, si fue nil, NO ESTA EN EL CACHE, ENTONCES DESCARGARLA
                request = Alamofire.request(.GET, recievedPost.imgUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let downloadedImg = UIImage(data: data!)!
                        self.postImage.image = downloadedImg
                        //ya que esta descargada
                        
                        //GUARDARLA EN EL CACHE
                        FeedViewController.imageCache.setObject(downloadedImg, forKey: self.post.imgUrl!)
                    }
                    
                }) //make sure we downloaded an image
            }
            
        
        } else {
            //Si no hubo imagen,entonces escondemos el ImageView
            self.postImage.hidden = true
        }
        
        
    }
    
    

}
