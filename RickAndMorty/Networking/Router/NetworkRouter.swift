//
//  NetworkRouter.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

public typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
    associatedtype Request: ResourceRequestType
    func get(request: Request, completion: @escaping NetworkCompletion)
}

class Router<Request: ResourceRequestType>: NetworkRouter {

    func get(request: Request, completion: @escaping NetworkCompletion) {
        URLSession.shared.dataTask(with: buildRequestFrom(request), completionHandler: completion).resume()
    }

    private func buildRequestFrom(_ type: Request) -> URLRequest {
        let url = URL(string: type.requestURL)!
        print("Built url \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        return request
    }

}
