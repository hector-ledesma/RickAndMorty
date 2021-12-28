//
//  ResourceRequestType.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

public typealias URLQueries = [String:String]

enum HTTPMethodType: String {
    case get    = "GET"
    // case post.... etc
}

enum APIResourceEndpoint: String {
    case character = "/character"
    case location  = "/location"
    // can add mre endpoints or update existing ones as needed
}

/**
 Any given network call will involve a request, and a completion handler. This protocol allows us to build the request.

 The idea is that each property will be used to fild the final url, as well as the HTTP method for the request:
 
 - baseURL: the API's base url to which all components will be appended regardless of the resource we're trying to access.
 - resource: `APIResourceEndpoint` determines the endpoint of the resource we're requesting from the API.
 - queries: path components to be added to the URL after the endpoint.
 - requestURL: convenience property that should return the final URL that can be used to build the request.

 # Implementation
 Using an enum that conforms to this protocol allows us to dynamically allocate the data within the implementation by simply switching over self.
 ```
 enum Example {
     case request
     case requestWithParams(param1, param2)
 }

 extension Example: ResourceRequestType {
    var baseURL: String {
        switch self {
         case request:
         case requestWithParams(param1, param2):
         default:
        }
    }
 
    var resource: APIResourceEndpoint {
        ...
    }
 
    var queries: String {
        ...
    }
 
    var httpMethod: HTTPMethodType {
        ...
    }
 
    var requestURL: String {
        ...
    }
 
 }
 ```
 */
protocol ResourceRequestType {
    var baseURL: String { get }
    var resource: APIResourceEndpoint { get }
    var queries: String { get }
    var httpMethod: HTTPMethodType { get }
    var requestURL: String { get }
}
