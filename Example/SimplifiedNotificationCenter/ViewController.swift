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
    @IBAction func subscribeTap(_ sender: AnyObject?) {
        notifications.stringNotification.subscribe {[weak self] value in
            print(value)
            self?.receivedText.text = value
        }
    }
    @IBAction func unsubscribeTap(_ sender: AnyObject) {
        notifications.stringNotification.unSubscribe()
    }
    @IBAction func postNotificationTap(_ sender: AnyObject) {
        notifications.stringNotification.post(textForSending.text!)
    }
    @IBAction func reInitTap(_ sender: AnyObject?) {
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
        notifications.objectNotification.subscribe {value in
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
        
        print(sampleClass)
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
        notifications.testNotification.subscribe{value in
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

