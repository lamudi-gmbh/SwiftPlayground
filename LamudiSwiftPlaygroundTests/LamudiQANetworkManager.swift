//
//  LamudiQANetworkManager.swift
//  LamudiSwiftPlayground
//
//  Created by Jan Krukowski on 28/05/15.
//  Copyright (c) 2015 Jan Krukowski. All rights reserved.
//

import Foundation

import UIKit
import XCTest


class LamudiQANetworkManager: XCTestCase {
    
    var requestQueue: BaseRequestQueue?
    
    override func setUp() {
        super.setUp()
        self.requestQueue = BaseRequestQueue()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHttpGET() {
        let expectation = expectationWithDescription("Http GET Test")
        let request = TestRequest(method: HTTPMethod.GET,
            success: { (data, response) in
                let httpResponse = response as! NSHTTPURLResponse
                XCTAssertEqual(httpResponse.statusCode, 200, "Received 200 from server")
                expectation.fulfill()
            },
            fail: { (response) in
                let httpResponse = response as? NSHTTPURLResponse
                XCTFail("Fail with \(httpResponse?.statusCode)")
                expectation.fulfill()
        })

        self.requestQueue?.addRequest(request)
        
        waitForExpectationsWithTimeout(request.timeout) { (error) in
            request.cancel()
        }
    }
}
