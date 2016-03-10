//
//  Post.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/10/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import Foundation


class Post {
    
    private var _postDescription: String!
    private var _imgUrl: String? //optional because posts may contain or not images
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    
    
    var postDescription: String! {
        return _postDescription
    }
    
    var imgUrl: String? {
        return _imgUrl
    }
    
    var likes: Int! {
        return _likes
    }
    
    var username: String! {
        return _username
    }
    
    
    
    
    //Constructor, the values required
    
    init(description: String, imageUrl: String?, username: String) {
        self._postDescription = description
        self._imgUrl = imageUrl
        self._username = username
    }
    
    
    
    
    init(postKey: String, dict: Dictionary<String, AnyObject>) {
        
        self._postKey = postKey
        
        if let likes = dict["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dict["imgUrl"] as? String {
            self._imgUrl = imgUrl
        }
        
        if let desc = dict["description"] as? String {
            self._postDescription = desc
        }
        
    }
    
    
}