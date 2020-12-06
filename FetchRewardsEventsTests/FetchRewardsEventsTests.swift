//
//  FetchRewardsEventsTests.swift
//  FetchRewardsEventsTests
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import XCTest
@testable import FetchRewardsEvents

class FetchRewardsEventsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testEvents() {
        let example = Event(id: 3333, title: "Example", datetimeUtc: "2020-12-05T08:30:00", venue: Venue(displayLocation: "Chicago, IL"), performers: [Performer(id: 20, image: "example.url")])
        
        XCTAssertTrue(example.id == 3333)
        XCTAssertTrue(example.title == "Example")
        XCTAssertTrue(example.datetimeUtc == "2020-12-05T08:30:00")
        XCTAssertTrue(example.venue.displayLocation == "Chicago, IL")
        XCTAssertTrue(example.performers.count == 1)
        XCTAssertTrue(example.performers[0].id == 20)
        XCTAssertTrue(example.performers[0].image == "example.url")
    }

}
