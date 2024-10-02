//
//  carnageTests.swift
//  carnageTests
//
//  Created by Diogo Domingos on 04/09/2024.
//

import XCTest
@testable import carnage

final class carnageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test retrieve token function.
    ///
    /// todo: delete this user lol.
    func testRetrieveTokens() async throws {
        let tokens = try await API.getTokens(email: "poopenfart@gmail.com", password: "123456")
        
        print("Access token: \(tokens.token)")
        print("Refresh token: \(tokens.refresh_token)")
    }
    
    func testRetrieveRoutines() async throws {
        let routines = try await API.getRoutines()
        
        print(routines)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
