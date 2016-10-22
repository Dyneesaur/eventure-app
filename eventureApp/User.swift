//
//  User.swift
//  eventure-app
//
//  Created by Lucas Padden on 10/19/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

/* 
 /  This is the user class. It defines the structure for a user object.
 /
 /
 */


import Foundation
class User {
    
    // instance variables for the user class
    var chatrooms: Array<Chatroom>
    let id_number: String
    var first_name: String
    var last_name: String
    var age: Int
    let facebookID: String
    var twitter: String
    var occupation: String
    var eventsAttended: Array<Event>
    var messages : Array<Message>
   
    init(chatRm: Array<Chatroom>, idNum: String, firstName: String, lastName: String, user_age: Int, user_fb_id: String, user_twitter: String, user_occupation: String, usr_events_attended: Array<Event>, usr_messages: Array<Message>) {
        self.chatrooms = chatRm
        self.id_number = idNum
        self.first_name = firstName
        self.last_name = lastName
        self.age = user_age
        self.facebookID = user_fb_id
        self.twitter = user_twitter
        self.occupation = user_occupation
        self.eventsAttended = usr_events_attended
        self.messages = usr_messages
    }
    
    /***** Functions for a user object *****/
    
    // Getter functions for the user class.
    
    func getChatRooms() -> Array<Chatroom> {
        // returns an array of chatrooms that a user is apart of
        return chatrooms
        
    }
    
    func getUserIDNumber() -> String {
        // returns a users id number
        return id_number
    }
    
    func getFirstName() -> String {
        // returns a users first name
        return first_name
    }
    
    func getLastName() -> String {
        // returns a users last name
        return last_name
    }
    
    func getAge() -> Int {
        // returns a user's age
        return age
    }
    
    func getFacebookID() -> String {
        // get the users facebook id
        // this probably entails some work so I will leave it blank till we figure it out.
        // ill return the facebookID for now.
        return facebookID
    }
    
    func getTwitterName() -> String {
        // this will return a user's twitter account name
        return twitter
    }
    
    func getOccupation() -> String {
        // this will return a user's occupation
        return occupation
    }
    
    func getEventsAttended() -> Array<Event> {
        // this will return an array of the events that a user has attended in the past
        return eventsAttended
    }
    
    func getMessages() -> Array<Message> {
        // this will return an array of the messages a user has sent
        // we will probably figure out a way to only store them till a certain time
        // that could be a utility function
        return messages
    }
    
    
    
    
    
    
    // Setter functions for the user class
    
    func setFirstName(firstName: String) {
        // this function sets the first name of a user
        first_name = firstName
    }
    
    func setLastName(lastName: String) {
        // this function sets the last name of a user
        last_name = lastName
    }
    
    func setTwitterHandle(twitterHandle: String) {
        // this function sets the twitter handle of a user
        twitter = twitterHandle
    }
    
    func setOccupation(user_occupation: String) {
        // this function sets the occupation of a user
        occupation = user_occupation
    }
    
    func setUserAge(user_age: Int) {
        // this function sets the users age
        age = user_age
    }
    
    
    
    
    
    
    
}
