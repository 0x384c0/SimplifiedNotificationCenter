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
            print(value)
            self?.receivedText.text = value
        }
    }
    @IBAction func unsubscribeTap(sender: AnyObject) {
        notifications.stringNotification.unSubscribe()
    }
    @IBAction func postNotificationTap(sender: AnyObject) {
        notifications.stringNotification.post(textForSending.text!)
    }
    @IBAction func reInitTap(sender: AnyObject?) {
        subscribeTap(nil)
        objectNotificationExample()
        comunicationBetweenDifferentClassesExample()
    }
    //MARK: LifeCycle
    override func viewDidLoad() {
        reInitTap(nil)
    }
    
    //MARK: Others
    var notifications = Notifications()
    
    func objectNotificationExample(){
        print("\n\(#function)")
        notifications.objectNotification.subscribe {(value, sender) in
            print("sender: \(sender.dynamicType)")
            print("value:  \(value.title)")
        }
        notifications.objectNotification.post(SampleObject(title: "objectNotificationExample Sample Title") )
    }
    
    func comunicationBetweenDifferentClassesExample(){
        print("\n\(#function)")
        let
        sampleClass = SampleClass(),
        anotherClass = AnotherClass()
        anotherClass.post()
        
        sampleClass//supress unused var warning
    }
    
}

class Notifications{
    let
    testNotification    = SimpleNotification<String>         (name: "Example.testNotification"),
    stringNotification  = SimpleNotification<String>         (name: "Example.stringNotification"),
    objectNotification  = SimpleNotification<SampleObject>   (name: "Example.objectNotification")
}




//MARK: samples
class SampleObject {
    init(title:String){
        self.title = title
    }
    let title:String
}

class SampleClass {
    var notifications = Notifications()
    init(){
        notifications.testNotification.subscribe{(value, _) in
            print("value: \(value)")
        }
    }
}

class AnotherClass {
    func post(){
        Notifications().testNotification.post("comunicationBetweenDifferentClassesExample Test text")
        //or use
        //SimpleNotification<String>(name: "Example.testNotification").post("comunicationBetweenDifferentClassesExample Test text")
    }
}

