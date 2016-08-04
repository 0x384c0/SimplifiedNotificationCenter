import UIKit
import XCTest
import SimplifiedNotificationCenter
import MapKit


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
            XCTAssertNil(sender, "sender not nil")
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
    
    
    
    func testString(){
        let notifications = Notifications()
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectationWithDescription("ready.\(#function)")
        //test subscribed
        print("SUBSCRIBE")
        notifications.stringboolNotification.subscribe { (value, sender) in
            print("RECEIVE")
            XCTAssertNil(sender, "sender not nil")
            XCTAssertTrue(value == "test", "Error receive value")
            readyExpectation.fulfill()
        }
        print("SEND")
        notifications.stringboolNotification.post("test")
        
        waitForExpectationsWithTimeout(1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
    }
    
    func testObject(){
        let
        notification = SimpleNotification<CLLocationCoordinate2D> (name: "TEST_Coord"),
        coord = CLLocationCoordinate2DMake(1, 1)
        
        
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectationWithDescription("ready.\(#function)")
        //test subscribed
        print("SUBSCRIBE")
        notification.subscribe { (value, sender) in
            print("RECEIVE")
            XCTAssertNil(sender, "sender not nil")
            XCTAssertTrue(value.latitude == 1, "Error receive value")
            readyExpectation.fulfill()
        }
        print("SEND")
        notification.post(coord)
        
        waitForExpectationsWithTimeout(1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
    }
    
}


class Notifications {
    var
    boolNotification                = SimpleNotification<Bool>                                    (name: "TEST_BOOL"),
    stringboolNotification          = SimpleNotification<String>                                  (name: "TEST_STRING")
}