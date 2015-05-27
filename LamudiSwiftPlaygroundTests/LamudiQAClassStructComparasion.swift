//
//  LamudiQA_Tests.swift
//  LamudiQA Tests
//
//  Created by Lamudi on 29.04.15.
//  Copyright (c) 2015 Lamudi. All rights reserved.
//

import UIKit
import XCTest

struct StackStruct<T> {
    private var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

class StackClass<T> {
    private var items = [T]()
    
    func push(item: T) {
        items.append(item)
    }
    
    func pop() -> T {
        return items.removeLast()
    }
}

class SimpleClass<T> {
    
    var item: T
    
    init(item: T) {
        self.item = item
    }
}

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
    
    func testPerformanceStack() {
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
