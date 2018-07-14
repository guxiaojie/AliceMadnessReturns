//
//  HuntShowdownTests.swift
//  HuntShowdownTests
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import XCTest
@testable import HuntShowdown

class HuntShowdownTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJSONParser() {
        let dailyBuzz = ExtractionPoint().getDailyBuzz("test-game")
        if dailyBuzz?.items != nil {
            if (dailyBuzz?.items.count)! > 0 {
                let quiz = dailyBuzz?.items[0]
                if quiz != nil {
                    
                } else {
                    XCTFail("json parser failed - when comes to quiz")
                }
            }
        } else {
            XCTFail("json parser failed")
        }
    }
    
    func testGetQuiz() {
        let viewController = MasterViewController()
        let index = 617
        let amount = viewController.quiz(index: index)
        if amount <= index {
            XCTFail("out of range")
        }
    }
    
    func testGetQuizInRange() {
        let viewController = MasterViewController()
        let index = 20
        let amount = viewController.quiz(index: index)
        if amount <= index {
            XCTFail("out of range")
        }
    }
    
}
