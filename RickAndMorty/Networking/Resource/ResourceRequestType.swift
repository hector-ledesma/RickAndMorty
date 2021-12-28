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
}

enum APIResourceEndpoint: String {
    case character = "/character"
    case location  = "/location"
}

protocol ResourceRequestType {
    var baseURL: String { get }
    var resource: APIResourceEndpoint { get }
    var queries: String { get }
    var httpMethod: HTTPMethodType { get }
    var requestURL: String { get }
}
