//
//  DataService.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/8/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import Foundation
import Firebase

//ESTO ES UN SINGLETON, es globally accesible



let URL_BASE = "https://social-network-by-js.firebaseio.com"


class DataService {
    
    static let ds = DataService()
    
    
    //INTERACTION WITH FIREBASE. reference link
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    
    //THE ACTUAL GETTER TO GET OUR REFERENCE TO FIREBASE. globally accesible in the project
    public var REF_BASE: Firebase {
        
        return _REF_BASE
    
    }
    
    public var REF_POSTS: Firebase {
        
        return _REF_POSTS
        
    }
    
    public var REF_USERS: Firebase {
        
        return _REF_USERS
        
    }
    
    
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>)
    {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    
    
    
    
    
}
