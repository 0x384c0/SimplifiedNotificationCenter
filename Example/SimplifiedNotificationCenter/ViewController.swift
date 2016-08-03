//
//  ViewController.swift
//  SimplifiedNotificationCenter
//
//  Created by 0x384c0 on 08/03/2016.
//  Copyright (c) 2016 0x384c0. All rights reserved.
//

import UIKit
import SimplifiedNotificationCenter

class ViewController: UIViewController {
    //MARK: UI
    @IBOutlet weak var textForSending: UITextField!
    @IBOutlet weak var receivedText: UILabel!
    //MARK: UI Actions
    @IBAction func subscribeTap(sender: AnyObject?) {
        notifications.stringNotification.subscribe {[weak self] (value, sender) in
            self?.receivedText.text = value
        }
    }
    @IBAction func unsubscribeTap(sender: AnyObject) {
        notifications.stringNotification.unSubscribe()
    }
    @IBAction func postNotificationTap(sender: AnyObject) {
        notifications.stringNotification.post(textForSending.text!)
    }
    //MARK: LifeCycle
    override func viewDidLoad() {
        subscribeTap(nil)
        objectNotificationExample()
    }
    
    //MARK: Others
    var notifications = Notifications()
    
    func objectNotificationExample(){
        notifications.objectNotification.subscribe {(value, sender) in
            print("sender: \(sender.dynamicType)")
            print("value: \(value.title)")
        }
        notifications.objectNotification.post( SampleObject(title: "Sample Title") )
    }
    
}

class Notifications{
    var
    stringNotification = SimpleNotification<String>         (name: "Example.stringNotification"),
    objectNotification = SimpleNotification<SampleObject>   (name: "Example.objectNotification")
}

class SampleObject {
    init(title:String){
        self.title = title
    }
    let title:String
}

