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
    func addEventTreeStructure(eventRoot: String, title: String, description: String, avatar: String, Category: String, chatChannel: Int, images: NSMutableArray, startDate: String, endDate: String, longitude: Double, latitude: Double) {
        
       
        
        let eventKey = DBReference.child(eventRoot).childByAutoId()
        
        //        var event = Event(dateCreated: dateCreated, eventID: eventKey.key, avatar: avatar, chatChannelNumber: chatChannel, images: images, category: Category, title: title, longitude: longitude,  latitude: latitude)
        // print("Event id" + event.event_id)
        
        eventKey.child("title").setValue(title)
        eventKey.child("description").setValue(description)
        eventKey.child("avatar").setValue(avatar)
        eventKey.child("category").setValue(Category)
        eventKey.child("chatChannel").setValue(chatChannel)
        eventKey.child("images").setValue(images)
        eventKey.child("startDate").setValue(startDate)
        eventKey.child("endDate").setValue(endDate)
        eventKey.child("longitude").setValue(longitude)
        eventKey.child("latitude").setValue(latitude)
        
    }
    
    
   
}
