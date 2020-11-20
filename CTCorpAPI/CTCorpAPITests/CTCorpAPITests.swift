//
//  CTCorpAPITests.swift
//  CTCorpAPITests
//
//  Created by Aslam Azis on 19/11/20.
//

import XCTest
@testable import CTCorpAPI

class CTCorpAPITests: XCTestCase {
    
    override func setUp() {
        let config = Configuration()
        config.debuggable = true
        CTCorpAPI.shared.setConfig(config)
    }
    
    func testSearchUsers() throws {
        let request = SearchUsersRequest()
        let expect = expectation(description: "Calling Search Users API")
        var users: [User]?
        _ = request.searchUsers(keyword: "andi") { (result) in
            if (result.code < 300) {
                users = result.data?.items
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 15) { (error) in
            XCTAssertNotNil(users)
        }
    }

}
