import UIKit
import XCTest
import SimplifiedNotificationCenter


class Tests: XCTestCase {
    
    func testNotifications() {
        let notifications = Notifications()
        testNotification(notifications.boolNotification,        object: true)
        testNotification(notifications.stringboolNotification,  object: "true")
    }
    
    private func testNotification<T:BaseNotificationProtocol>(notification:T,object:T.T){
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectationWithDescription("ready.\(#function)")
        //test subscribed
        print("SUBSCRIBE")
        notification.subscribe { (value, sender) in
            print("RECEIVE")
            readyExpectation.fulfill()
        }
        print("SEND")
        notification.post(object)
        
        waitForExpectationsWithTimeout(1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
        
        
        //test unsusbscribed
        notification.subscribe { (value, sender) in
            print("RECEIVE")
            XCTAssertTrue(false, "Notification is not unsubscribed")
        }
        print("UNSUBSCRIBE")
        notification.unSubscribe()
        print("SEND")
        notification.post(object)
        
    }
    
}


class Notifications {
    var
    boolNotification                = SimpleNotification<Bool>                                    (name: "TEST_BOOL"),
    stringboolNotification          = SimpleNotification<String>                                  (name: "TEST_STRING")
}