//
//  DBAccessObject.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import FirebaseDatabase
import Firebase
import FirebaseAuth

/*
 /
 /  This class is used for all the DB handlers, i.e inserting data, retrieving data, updating the db
 /
 */


import Foundation

class DBAccessObject {
    
    var DBReference: FIRDatabaseReference
    
    init(DBAccessObj: FIRDatabaseReference) {
        
        // creates a reference to access the database
        
        self.DBReference = DBAccessObj.database.reference()
        
    }
    
    // adds an event to the db
    func addEventTreeStructure(eventRoot: String, title: String, description: String, avatar: String, Category: String, chatChannel: Int, images: NSMutableArray, dateCreated: String) {
        
        let eventKey = DBReference.child(eventRoot).childByAutoId()
        eventKey.child("title").setValue(title)
        eventKey.child("description").setValue(description)
        eventKey.child("avatar").setValue(avatar)
        eventKey.child("category").setValue(Category)
        eventKey.child("chatChannel").setValue(chatChannel)
        eventKey.child("images").setValue(images)
        eventKey.child("dateCreated").setValue(dateCreated)
        
    }
}
