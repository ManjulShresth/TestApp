//
//  ViewControllerTest.swift
//  TestNikeTests
//
//  Created by Manjul Shrestha on 8/6/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation
import XCTest
@testable import TestNike

class ViewControllerTest: XCTestCase {
    var viewControllerUnderTest: AlbumTableVC!

    override func setUp() {
        super.setUp()
        
        self.viewControllerUnderTest = AlbumTableVC()
        self.viewControllerUnderTest.viewDidLoad()
        self.viewControllerUnderTest.populate()
        
        self.viewControllerUnderTest.albumArray.append(FeedResult())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.albumTable)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.albumTable.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.albumTable.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.albumTable, cellForRowAt: IndexPath(row: 0, section: 0)) as? AlbumTableCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "AlbumCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.albumTable, cellForRowAt: IndexPath(row: 0, section: 0)) as? AlbumTableCell
        XCTAssertEqual(cell?.albumArtistLabel.text, nil)
    }

}
