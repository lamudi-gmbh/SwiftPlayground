//
//  LamudiQA_Tests.swift
//  LamudiQA Tests
//
//  Created by Lamudi on 29.04.15.
//  Copyright (c) 2015 Lamudi. All rights reserved.
//

import UIKit
import XCTest


class LamudiQAClassStructComparasion: XCTestCase {
    
    var stackStruct = StackStruct<SimpleClass<Int>>()
    var stackClass = StackClass<SimpleClass<Int>>()
    let testCases = 1000000
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceStruct() {
        self.measureBlock() {
            for i in 0..<self.testCases {
                self.stackStruct.push(SimpleClass<Int>(item: i))
            }
            
            for i in 0..<self.testCases {
                self.stackStruct.pop()
            }
        }
    }
    
    func testPerformanceClass() {
        self.measureBlock() {
            for i in 0..<self.testCases {
                self.stackClass.push(SimpleClass<Int>(item: i))
            }
            
            for i in 0..<self.testCases {
                self.stackClass.pop()
            }
        }
    }
    
}
