//
//  Twitter_CounterUITests.swift
//  Twitter-CounterUITests
//
//  Created by Yousef Elsayed on 01/10/2022.
//

import XCTest

final class Twitter_CounterUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        self.app = XCUIApplication()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.app = nil
    }

    func test_ExistanceOfTWTextView() {
        //Arrange
        self.app.launch()
        
        //Act
        let twTextViewExists = app.otherElements["twTextView"].exists
        
        //Assert
        XCTAssertTrue(twTextViewExists, "ERROR:- Couldn't find view of type twTextView")
    }
    
    func testCopyTextButtonExists_ShouldReturnTrue() {
        //Arrange
        self.app.launch()
        
        //Act
        let twTextViewExists = app.otherElements.buttons["copyTextButton"].exists
        
        //Assert
        XCTAssertTrue(twTextViewExists, "ERROR:- Couldn't find button of type copyTextButton")
    }
    
    func testClearTextButtonExists_ShouldReturnTrue() {
        //Arrange
        self.app.launch()
        
        //Act
        let twTextViewExists = app.otherElements.buttons["clearTextButton"].exists
        
        //Assert
        XCTAssertTrue(twTextViewExists, "ERROR:- Couldn't find button of type clearTextButton")
    }
    
    func testPostTweetButtonExists_ShouldReturnTrue() {
        //Arrange
        self.app.launch()
        
        //Act
        let twTextViewExists = app.otherElements.buttons["postTweetButton"].exists
        
        //Assert
        XCTAssertTrue(twTextViewExists, "ERROR:- Couldn't find button of type postTweetButton")
    }
    
    
    func test_TypingTextOnTextViewReflectOnTypedCharactersCountLabel_shouldReturnTrue() {
        //Arrange
        self.app.launch()
        
        //Act
        let twTextView = app.otherElements["twTextView"].textViews["myTextView"].firstMatch
        
        XCTAssertEqual(twTextView.elementType, .textView)
        
        twTextView.typeText("Hello")
        
        let typedCharactersLabel = app.staticTexts["typedCharactersLabel"]
        
        //Assert
        XCTAssertEqual(typedCharactersLabel.label , "5/280",  "ERROR:- Couldn't exact match of number of typed characters")

    }
}
