//
//  Parser.swift
//  LamudiSwiftPlayground
//
//  Created by Jan Krukowski on 28/05/15.
//  Copyright (c) 2015 Jan Krukowski. All rights reserved.
//

import Foundation


protocol ParserProtocol {
    typealias T
    func parse(data: NSData)
    init(success: (T) -> (), fail: () -> ())
}

class JSONParser: ParserProtocol {
    
    typealias T = [String:AnyObject]
    private let success: ([String:AnyObject]) -> ()
    private let fail: () -> ()
    
    required init(success: ([String:AnyObject]) -> (), fail: () -> ()) {
        self.success = success
        self.fail = fail
    }
    
    func parse(data: NSData) {
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
            var parseError: NSError?
            var result: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.allZeros,
                error: &parseError)
            
            if let _ = parseError {
                if let resultDictionary = result as? [String:AnyObject] {
                    success(resultDictionary)
                } else {
                    fail()
                }
            } else {
                fail()
            }
        } else {
            fail()
        }
    }
}
