//
//  SimpleNotification.swift
//  SimplifiedNotificationCenter
//
//  Created by Andrew Ashurow on 3/7/16.
//  Copyright © 2016 Andrew Ashurow. All rights reserved.
//

import Foundation

public class SimpleNotification<T> :BaseNotificationProtocol{
    public typealias SimpleNotificationHandler = (value:T, sender:AnyObject?) -> Void
    
    private var
    notificationHandler:SimpleNotificationHandler?,
    sender: AnyObject?,
    name: String
    
    public init(name: String, sender: AnyObject? = nil){
        self.name = name
        self.sender = sender
    }
    //MARK: public methods
    /**
     subscribe to notification with handler or unSubscribe.
     - parameter handler:  handler(value, sender). If handler == nil, unSubscribe() will be performed
     */
    public func subscribe(handler: SimpleNotificationHandler?){
        unSubscribe()
        if handler != nil {
            notificationHandler = handler
            _subscribe()
        }
    }
    /**
     Posts the notification with the given value to the specified center.
     - parameter object:  The data to be sent with the notification.
     */
    public func post(object: T) {
        if let object = object as? AnyObject{
            NSNotificationCenter.defaultCenter().postNotificationName(name, object: object)
        } else {
            handleError("SimpleNotification TYPE ERROR \n object \(object.dynamicType) is not AnyObject")
        }
    }
    /**
     Unsubscribe and remove notificationHandler
     */
    public func unSubscribe(){
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
        } else {
            var givenTypeString = "nil"
            if let givenType = notification.object?.dynamicType{
                givenTypeString = String(givenType)
            }
            handleError("SimpleNotification TYPE ERROR \n expected type: \(T.self) \n given type:     \(givenTypeString)")
        }
    }
    
    deinit {
        unSubscribe()
    }
    
}

//for tests
public protocol BaseNotificationProtocol {
    associatedtype T
    func post(object: T)
    func unSubscribe()
    func subscribe(handler: ((value:T, sender:AnyObject?) -> Void)?)
}

extension SimpleNotification {
    func handleError(text:String){
        #if DEBUG
            preconditionFailure(text)
        #else
            //dont crash app in production mode
            print(text)
        #endif
    }
}
