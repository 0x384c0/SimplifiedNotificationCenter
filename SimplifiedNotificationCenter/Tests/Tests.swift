import XCTest
import SimplifiedNotificationCenter
import MapKit


class Tests: XCTestCase {
    
    func testNotifications() {
        let notifications = Notifications()
        testNotification(notifications.boolNotification,        object: true)
        testNotification(notifications.stringboolNotification,  object: "true")
    }
    
    fileprivate func testNotification<T:BaseNotificationProtocol>(_ notification:T,object:T.T){
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectation(description: "ready.\(#function)")
        //test subscribed
        XCTAssertFalse(notification.isSubscribed)
        print("SUBSCRIBE")
        notification.subscribe { value in
            print("RECEIVE")
            XCTAssertNotNil(value, "value not nil")
            readyExpectation.fulfill()
        }
        XCTAssertTrue(notification.isSubscribed)
        print("SEND")
        notification.post(object)
        
        waitForExpectations(timeout: 1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
        
        
        //test unsusbscribed
        notification.subscribe { value in
            print("RECEIVE")
            XCTAssertTrue(false, "Notification is not unsubscribed")
        }
        print("UNSUBSCRIBE")
        notification.unSubscribe()
        XCTAssertFalse(notification.isSubscribed)
        print("SEND")
        notification.post(object)
        
    }
    
    
    
    func testString(){
        let notifications = Notifications()
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectation(description: "ready.\(#function)")
        //test subscribed
        XCTAssertFalse(notifications.stringboolNotification.isSubscribed)
        print("SUBSCRIBE")
        notifications.stringboolNotification.subscribe { value in
            print("RECEIVE")
            XCTAssertNotNil(value, "value not nil")
            XCTAssertTrue(value == "test", "Error receive value")
            readyExpectation.fulfill()
        }
        XCTAssertTrue(notifications.stringboolNotification.isSubscribed)
        print("SEND")
        notifications.stringboolNotification.post("test")
        
        waitForExpectations(timeout: 1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
    }
    
    func testObject(){
        let
        notification = SimpleNotification<CLLocationCoordinate2D> (name: "TEST_Coord"),
        coord = CLLocationCoordinate2DMake(1, 1)
        
        
        print("-+-+-+-+-+-+-+-+-+-+-+\n testing \(#function)\n-+-+-+-+-+-+-+-+-+-+-+")
        let readyExpectation = expectation(description: "ready.\(#function)")
        //test subscribed
        print("SUBSCRIBE")
        notification.subscribe { value in
            print("RECEIVE")
            XCTAssertNotNil(value, "value not nil")
            XCTAssertTrue(value.latitude == 1, "Error receive value")
            readyExpectation.fulfill()
        }
        print("SEND")
        notification.post(coord)
        
        waitForExpectations(timeout: 1){ error in
            XCTAssertNil(error, "\(#function) Error receive notification")
        }
    }
    
}


class Notifications {
    var
    boolNotification                = SimpleNotification<Bool>                                    (name: "TEST_BOOL"),
    stringboolNotification          = SimpleNotification<String>                                  (name: "TEST_STRING")
}
