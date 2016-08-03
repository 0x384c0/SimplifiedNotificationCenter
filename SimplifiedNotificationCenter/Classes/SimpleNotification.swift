//
//  SimpleNotification.swift
//  SimplifiedNotificationCenter
//
//  Created by Andrew Ashurow on 3/7/16.
//  Copyright © 2016 Andrew Ashurow. All rights reserved.
//

import Foundation

class SimpleNotification<T> :BaseNotificationProtocol{
    typealias SimpleNotificationHandler = (value:T, sender:AnyObject?) -> Void
    
    private var
    notificationHandler:SimpleNotificationHandler?,
    sender: AnyObject?,
    name: String
    
    init(name: String, sender: AnyObject? = nil){
        self.name = name
        self.sender = sender
    }
    //MARK: public methods
    /**
     subscribe to notification with handler or unSubscribe.
     - parameter handler:  handler(value, sender). If handler == nil, unSubscribe() will be performed
     */
    func subscribe(handler: SimpleNotificationHandler?){
        if handler == nil {
            unSubscribe()
        } else {
            _subscribe()
        }
        notificationHandler = handler
    }
    /**
     Posts the notification with the given value to the specified center.
     - parameter object:  The data to be sent with the notification.
     */
    func post(object: T) {
        if let object = object as? AnyObject{
            NSNotificationCenter.defaultCenter().postNotificationName(name, object: object)
        }
    }
    /**
     Unsubscribe and remove notificationHandler
     */
    func unSubscribe(){
        notificationHandler = nil
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: private methods
    private func _subscribe(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(self.methodOfReceivedNotification(_:)),
            name:name,
            object: nil
        )
    }
    
    @objc func methodOfReceivedNotification(notification: NSNotification){
        if let value = notification.object as? T {
            notificationHandler?(value: value, sender: sender)
        }
    }
    
    deinit {
        unSubscribe()
    }
    
}

//for tests
protocol BaseNotificationProtocol {
    associatedtype T
    func post(object: T)
    func unSubscribe()
    func subscribe(handler: ((value:T, sender:AnyObject?) -> Void)?)
}
