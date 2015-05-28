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
    
    func testNetwork() {
        let request = TestRequest(method: HTTPMethod.GET,
            success: { (data, httpResponse) in
                XCTAssertEqual(httpResponse.statusCode, 200, "Received 200 from server")
            },
            fail: { (httpResponse) in
                XCTFail("Fail with \(httpResponse?.statusCode)")
        })
        self.requestQueue?.addRequest(request)
    }
}
