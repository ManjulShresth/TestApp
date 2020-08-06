//
//  TestNikeTests.swift
//  TestNikeTests
//
//  Created by Manjul Shrestha on 8/3/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import XCTest
@testable import TestNike

class TestNikeTests: XCTestCase {

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
    
    func testTableView(){
        let vc = AlbumTableVC()
        XCTAssertNotNil(vc.albumTable)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
