# SimplifiedNotificationCenter

[![CI Status](http://img.shields.io/travis/0x384c0/SimplifiedNotificationCenter.svg?style=flat)](https://travis-ci.org/0x384c0/SimplifiedNotificationCenter)
[![Version](https://img.shields.io/cocoapods/v/SimplifiedNotificationCenter.svg?style=flat)](http://cocoapods.org/pods/SimplifiedNotificationCenter)
[![License](https://img.shields.io/cocoapods/l/SimplifiedNotificationCenter.svg?style=flat)](http://cocoapods.org/pods/SimplifiedNotificationCenter)
[![Platform](https://img.shields.io/cocoapods/p/SimplifiedNotificationCenter.svg?style=flat)](http://cocoapods.org/pods/SimplifiedNotificationCenter)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=0x384c0/simplifiednotificationcenter)](http://clayallsopp.github.io/readme-score?url=0x384c0/simplifiednotificationcenter)

This is a tiny swift wrapper around NSNotificationCenter with generics, that aids in the creation of Notifications.

## Installation

SimplifiedNotificationCenter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SimplifiedNotificationCenter"
```

If you using swift 3, add the following line to your Podfile:

```ruby
pod "SimplifiedNotificationCenter",
:git => 'https://github.com/0x384c0/SimplifiedNotificationCenter.git',
:branch => 'swift3'
```

## Usage

Add `import SimplifiedNotificationCenter` to your source code

```Swift
// create notification
let notification = SimpleNotification<String>(name: "Example.notification")

// subscribe
notification.subscribe {(value, sender) in
    print("sender: \(sender.dynamicType)")
    print("value:  \(value.title)")
}

// post
notification.post("sample text")
//sample text and sender will be printed
```

Passing notifications between different places of application

Notifications holder:
```Swift
class Notifications{
    let testNotification    = SimpleNotification<String>         (name: "Example.testNotification")
}
```
Notifications handler:
```Swift
class SampleClass {
        //instance of notifications holder
        var notifications = Notifications()
        init(){
            //subscribe
            notifications.testNotification.subscribe{(value, _) in
                print("value: \(value)")
        }
    }
}
```
Notifications caller:
```Swift
class AnotherClass {
    func post(){
        //post
        Notifications().testNotification.post("comunicationBetweenDifferentClassesExample Test text")
        //or use
        //SimpleNotification<String>(name: "Example.testNotification").post("comunicationBetweenDifferentClassesExample Test text")
        //but it is not safe
    }
}
```
Example:
```Swift
let
sampleClass = SampleClass(),
anotherClass = AnotherClass()
anotherClass.post()
//comunicationBetweenDifferentClassesExample Test text will be printed

```


## Example App

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- `ios 8.0 and higher`
- `swift v2.2 and higher`


## Unit Tests

SimplifiedNotificationCenter includes a suite of unit tests within the Tests subdirectory. These tests can be run simply be executed the test action on the platform framework you would like to test.

## Author

0x384c0, 0x384c0@gmail.com

## License

SimplifiedNotificationCenter is available under the MIT license. See the LICENSE file for more info.
