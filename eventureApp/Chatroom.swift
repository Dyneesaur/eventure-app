//
//  Chatroom.swift
//  eventure-app
//
//  Created by Lucas Padden on 10/19/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import Foundation
class Chatroom {
    
    // instance variables for a chatroom object
    var chat_id: String
    var users: Array<User>
    var messages: Array<Message>
    
    init(chatID: String, users: Array<User>, messages: Array<Message>) {
        self.chat_id = chatID
        self.users = users
        self.messages = messages
    }
    
    /***** Functions for a chatroom object *****/
    
    // getter functions the chatroom class
    
    func getChatID() -> String {
        // this function returns the chatroom's chat id number
        return chat_id
    }
    
    func getUsers() -> Array<User> {
        // this function returns an array of users that are in the chatroom
        return users
    }
    
    func getMessages() -> Array<Message> {
        // this function returns an array of messages sent in the chatroom
        return messages
    }
    
    // other functions
    
    func addUserToChatroom(user: User) {
        // this function adds a user to the chatroom object users array
        users.append(user)
    }
    
  
    
}
