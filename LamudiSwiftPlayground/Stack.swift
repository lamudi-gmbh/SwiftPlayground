//
//  GenericObjects.swift
//  LamudiSwiftPlayground
//
//  Created by Jan Krukowski on 27/05/15.
//  Copyright (c) 2015 Jan Krukowski. All rights reserved.
//

import Foundation

public struct StackStruct<T> {
    private var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

public class StackClass<T> {
    private var items = [T]()
    
    func push(item: T) {
        items.append(item)
    }
    
    func pop() -> T {
        return items.removeLast()
    }
}

public class SimpleClass<T> {
    
    var item: T
    
    init(item: T) {
        self.item = item
    }
}