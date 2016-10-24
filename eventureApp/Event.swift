//
//  Event.swift
//  eventure-app
//
//  Created by Lucas Padden on 10/19/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//


/* 
 /  This is the event class.  It defines the structure of an event object.
 /
 /
 */
import Foundation
class Event {
    
    // instance variables for initializer
    let created: NSDate
    let event_id: String
    var avatar_img: String
    let channelNum: Int
    var start_date: NSDate        
    var end_date: NSDate
    var icon_img: String
    var event_images: NSMutableArray
    var event_category: String
    let host_id: String  // this will be firstbase uid
    var title_text: String
    
    // define an initializer for Event objects
    init(dateCreated: NSDate, eventID: String, avatar: String, chatChannelNumber: Int, startDate: NSDate, endDate: NSDate, icon: String, images: NSMutableArray, category: String, host: String, title: String) {
        
        self.created = dateCreated
        self.event_id = eventID
        self.avatar_img = avatar
        self.channelNum = chatChannelNumber
        self.start_date = startDate
        self.end_date = endDate
        self.icon_img = icon
        self.event_images = images
        self.event_category = category
        self.host_id = host
        self.title_text = title
        
    }
    
    /****** define functions for the event class ******/
    
    // getter functions for an event object
    func getDateCreated() -> NSDate {
        // returns the date that the event was created
        return created
    }
    
    func getEventID() -> String {
        // returns the event id for an event object
        return event_id
    }
    
    func getAvatarImage() -> String {
        // returns a link to the images address on the internet
        return avatar_img
    }
    
    func getStartDate() -> NSDate {
        // returns the date the event is scheduled to start
        return start_date
    }
    
    func getEndDate() -> NSDate {
        // returns the date that the event is scheduled to end
        return end_date
    }
    
    func getIconImage() -> String {
        // returns a link to the images address on the internet
        return icon_img
    }
    
    func getEventImages() -> NSMutableArray {
        // returns an array of links to images taken at the event
        // images may need to be hosted somewhere?
        // if a user posts an image maybe the link can be gathered from its location on the server
        return event_images
    }
    
    func getHostID() -> String {
        // return the user's host ID possibly could be a string or integer not sure
        // for now it will be a string
        return host_id
    }
    
    func getTitleText() -> String {
        // returns the title text of the event
        return title_text
    }
    
    // setter functions for an event object
    
    func setAvatarImg(imageLink: String) {
        // sets the avatar image for an event
        avatar_img = imageLink
    }
    
    func setStartDate(startDate: NSDate) {
        // sets the start date for an event
        start_date = startDate
    }
    
    func setEndDate(endDate: NSDate) {
        // sets the end date for an event
        end_date = endDate
    }
    
    func setEventCategroy(eventCategory: String) {
        // sets the event category for an event object
        event_category = eventCategory
    }
    
    func setIconImage(iconImage: String) {
        // sets the icon image for an event
        icon_img = iconImage
    }
    
    // other functions
    
    func addImage(image: String) {
        // adds an image to the event_images array.
        event_images.add(image)
    }
    
    
    
    
}
