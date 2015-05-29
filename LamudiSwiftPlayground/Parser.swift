//
//  Parser.swift
//  LamudiSwiftPlayground
//
//  Created by Jan Krukowski on 28/05/15.
//  Copyright (c) 2015 Jan Krukowski. All rights reserved.
//

import Foundation


protocol ParserDelegate {
    typealias T
    static func parse(data: NSData) -> ParserResult<T>
}

struct ParserResult<T> {
    var isValid: Bool
    var result: T
}

class JSONParser: ParserDelegate {
    
    class func parse(data: NSData) -> ParserResult<[String:AnyObject]?> {
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
            var parseError: NSError?
            var result: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.allZeros,
                error: &parseError)
            
            if parseError != nil {
                return ParserResult(isValid: false, result: nil)
            }
            
            if let resultDictionary = result as? [String:AnyObject] {
                return ParserResult(isValid: true, result: resultDictionary)
            } else {
                return ParserResult(isValid: false, result: nil)
            }
        }
        return ParserResult(isValid: false, result: nil)
    }
}
