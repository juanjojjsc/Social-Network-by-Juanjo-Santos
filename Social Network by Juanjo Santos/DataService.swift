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


class DataService {
    
    static let ds = DataService()
    
    
    //INTERACTION WITH FIREBASE. reference link
    
    private var _REF_BASE = Firebase(url: "https://social-network-by-js.firebaseio.com")
    
    
    //THE ACTUAL GETTER TO GET OUR REFERENCE TO FIREBASE. globally accesible in the project
    public var REF_BASE: Firebase {
        
        return _REF_BASE
    
    }
    
}
