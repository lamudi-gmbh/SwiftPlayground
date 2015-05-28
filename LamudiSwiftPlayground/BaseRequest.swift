//
//  NetworkManager.swift
//  LamudiSwiftPlayground
//
//  Created by Jan Krukowski on 27/05/15.
//  Copyright (c) 2015 Jan Krukowski. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class BaseRequestQueue {
    private let operationQueue = NSOperationQueue()
    
    init() {
        operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount
    }
    
    func addRequest(request: BaseRequest) {
        self.operationQueue.addOperation(request)
    }
}

class BaseRequest: NSOperation {
    
    let timeout: NSTimeInterval = 30.0
    let method: HTTPMethod
    let success: (NSData, NSURLResponse) -> ()
    let fail: (NSURLResponse?) -> ()
    
    init(method: HTTPMethod, success: (NSData, NSURLResponse) -> (), fail: (NSURLResponse?) -> ()) {
        self.method = method
        self.success = success
        self.fail = fail
        super.init()
    }
    
    func path() -> String {
        preconditionFailure("Abstract method")
    }
    
    override func main() {
        if let url = NSURL(string: self.path()) {
            sendRequest(url)
        } else {
            // invalid url
            fatalError("Invalid url")
        }
    }
    
    func cachingPolicy() -> NSURLRequestCachePolicy {
        return .ReloadIgnoringLocalAndRemoteCacheData
    }
    
    func sendRequest(url: NSURL) {
        if self.cancelled {
            return
        }
        var request = NSURLRequest(URL: url)
        var response: NSURLResponse?
        var error: NSErrorPointer = nil
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: error)

        if let responseData = data {
            success(responseData, response!)
        } else {
            fail(response)
        }
    }
}

class TestRequest: BaseRequest {
    override func path() -> String {
        return "http://127.0.0.1:8000"
    }
}
