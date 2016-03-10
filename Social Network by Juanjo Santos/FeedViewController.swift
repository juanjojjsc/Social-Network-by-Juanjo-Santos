//
//  FeedViewController.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/9/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    //CREAR EL CACHE STATIC: ES QUE ES UNICO Y GLOBALLY ACCESIBLE
    static var imageCache = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 384
        
        //THIS IS HOW WE DOWNLOAD DATA FROM FIREBASE SE HACE EN EL VIEW DID LOAD
        
        // called whenever a value is updated on Firebase
        // first we get what we already have and then listen for changes
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            //print the changed data
            //print(snapshot.value)
            
            
            
            //VACIAR EL ARRAY
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                
                //EACH SNAP IS AN INDIVIDUAL POST OBJECT
                for snap in snapshots {
                    //print(snap)
                    
                    //Convertir el contenido a un Dictionary
                    if let postDict = snap.value as? Dictionary<String,AnyObject>
                    {
                        let key = snap.key
                        //CREAR UN OBJETO DE NUESTRA CLASE POST.SWIFT
                        let newPost = Post(postKey: key, dict: postDict)
                        self.posts.append(newPost)
                    }
                    
                }
                
            }
            
            
            //so everytime something new comes in, we reload the data
            self.tableView.reloadData()
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        /*------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        
        ESTA MAAAAAAAAL EDITAR LOS ATRIBUTOS DE LA CELL DESDE AQUI
        TIPO CAMBIAR LA IMAGEN, EL TEXTO DE LA LABEL, TODO ESO, MAL.
        
        
        DEBEMOS TENER UN METODO configureCell() DENTRO DE LA CLASE DE LA
        TABLE VIEW CELL QUE ESE SI LLAMAMOS DESDE AQUI
        
        ----------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------
        */
        
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? StylishPostTableViewCell {
            
            //Cancelamos la request cada vez que scrolleamos en la table view
            // para que no se descargue la anterior
            cell.request?.cancel()
            
            let currentPost = posts[indexPath.row]
            
            var cachedImg: UIImage?
            
            if let url = currentPost.imgUrl {
                //GET THE IMAGE FROM THE CACHE with its own KET that is the URL
                //if it exists
                cachedImg = FeedViewController.imageCache.objectForKey(url) as? UIImage
            }
            
            // if the image was assigned,pass it if it wasnt pass the empty image
            cell.configureCell(currentPost, recievedImg: cachedImg)
            return cell
            
        } else {
            return StylishPostTableViewCell()
        }
        
    }
    
    //SI NO HAY IMAGEN, HACER LA CELL MAS CHICA
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let currentPost = posts[indexPath.row]
        
        if currentPost.imgUrl == nil {
            return 130
        } else {
            return tableView.estimatedRowHeight
        }
        
    }

    

}
