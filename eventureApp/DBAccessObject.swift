//
//  DBAccessObject.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import FirebaseDatabase


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
    
    
    
    // functions to add data to our database tree
    
    
    // adds an event to the db
    func addEventTreeStructure(eventRoot: String, event: String, title: String, description: String, avatar: String, Category: String, chatChannel: Int, images: NSMutableArray, dateCreated: String) {
        
        // sets the title
        DBReference.child(eventRoot).child(event).child("title").setValue(title)
        
        DBReference.child(eventRoot).child(event).child("description").setValue(description)
        
        DBReference.child(eventRoot).child(event).child("avatar").setValue(avatar)
        
        DBReference.child(eventRoot).child(event).child("category").setValue(Category)
        
        DBReference.child(eventRoot).child(event).child("chatChannel").setValue(chatChannel)
        
        DBReference.child(eventRoot).child(event).child("images").setValue(images)
        
        DBReference.child(eventRoot).child(event).child("dateCreated").setValue(dateCreated)
        
        DBReference.child(eventRoot).child(event).child("eventID").childByAutoId()
        
        
    }
   
    
   
    
    
    
    
    

    
}
