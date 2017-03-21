//
//  SimpleNotification.swift
//  SimplifiedNotificationCenter
//
//  Created by Andrew Ashurow on 3/7/16.
//  Copyright © 2016 Andrew Ashurow. All rights reserved.
//

import Foundation
/// wrapper around NSNotificationCenter
open class SimpleNotification<T> :BaseNotificationProtocol{
    public typealias SimpleNotificationHandler = (_ value:T) -> Void
    
    fileprivate var
    notificationHandler:SimpleNotificationHandler?, // handler that store code block
    name: String                                    // name for NSNotificationCenter
    /**
     Creates notification class.
     - parameter name:  name for NSNotificationCenter
     */
    public init(name: String){
        self.name = name
    }
    //MARK: public variables
    /**
     returns true if subscribed
     */
    public var isSubscribed:Bool{
        return notificationHandler != nil
    }
    
    //MARK: public methods
    /**
     subscribe to notification with handler or unSubscribe from notifications.
     - parameter handler:  handler(value). If handler == nil, unSubscribe() will be performed
     */
    open func subscribe(_ handler: SimpleNotificationHandler?){
        unSubscribe()
        if let handler = handler {
            notificationHandler = handler
            _subscribe()
        }
    }
    /**
     Posts the notification with the given value to the specified center.
     - parameter object:  The data to be sent with the notification.
     */
    open func post(_ object: T) {
        let data = Wrapper<T>(theValue: object)
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: data)
    }
    /**
     Unsubscribe and remove notificationHandler
     */
    open func unSubscribe(){
        notificationHandler = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: private methods
    fileprivate func _subscribe(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.methodOfReceivedNotification(_:)),
            name:NSNotification.Name(rawValue: name),
            object: nil
        )
    }
    
    @objc func methodOfReceivedNotification(_ notification: Notification){
        if let value = (notification.object as? Wrapper<T>)?.wrappedValue{
            notificationHandler?(value)
        } else {
            var givenTypeString = "nil"
            let givenType = type(of: notification.object)
            givenTypeString = String(describing: givenType)
            
            handleError("SimpleNotification TYPE ERROR \n expected type: \(T.self) \n given type:     \(givenTypeString)")
        }
    }
    
    deinit {
        unSubscribe()
    }
    
}

//for tests
/// public for wrapper around NSNotificationCenter
public protocol BaseNotificationProtocol {
    associatedtype T
    /**
     returns true if subscribed
     */
    var isSubscribed:Bool{get}
    /**
     subscribe to notification with handler or unSubscribe from notifications.
     - parameter handler:  handler(value). If handler == nil, unSubscribe() will be performed
     */
    func subscribe(_ handler: ((_ value:T) -> Void)?)
    /**
     Posts the notification with the given value to the specified center.
     - parameter object:  The data to be sent with the notification.
     */
    func post(_ object: T)
    /**
     Unsubscribe and remove notificationHandler
     */
    func unSubscribe()
}

extension SimpleNotification {
    func handleError(_ text:String){
        #if DEBUG
            preconditionFailure(text)
        #else
            //dont crash app in production mode
            print(text)
        #endif
    }
}


class Wrapper<T>:AnyObject {
    var wrappedValue: T
    init(theValue: T) {
        wrappedValue = theValue
    }
}
