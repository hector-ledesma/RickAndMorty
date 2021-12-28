//
//  BackendController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation

/*

 */

public typealias URLQueries = [String:String]
public typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

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

enum CharacterResource {
    case page(number: Int)
    case id(_ id: Int)
}

extension CharacterResource: ResourceRequestType {
    var requestURL: String {
        return "\(baseURL)\(resource.rawValue)\(queries)"
    }

    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    var resource: APIResourceEndpoint {
        return .character
    }

    var queries: String {
        switch self {

        case .page(number: let number):
            return "?page=\(number)"
        case .id(_: let id):
            return "/\(id)"
        }
    }

    var httpMethod: HTTPMethodType {
        return .get
    }

}

enum LocationResource {
    case page(number: Int)
    case id(_ id: Int)
    case url(_ url: String)
}

extension LocationResource: ResourceRequestType {
    var requestURL: String {
        switch self {
        case .url(_: let url):
            return url
        default:
            return "\(baseURL)\(resource)\(queries)"
        }
    }

    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    var resource: APIResourceEndpoint {
        return .location
    }

    var queries: String {
        switch self {

        case .page(number: let number):
            return "?page=\(number)"
        case .id(_: let id):
            return "/\(id)"
        case .url(_: let url):
            return url
        }
    }

    var httpMethod: HTTPMethodType {
        return .get
    }

}

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
        return URLRequest(url: url)
    }

}


class BackendController {

    private let apiURL: URL = URL(string: "https://rickandmortyapi.com/api")!

    func getPage(_ page: Int, completion: @escaping (Any?, Error?) -> Void) {
//        var url = apiURL.appendingPathComponent("character")
        var comps = URLComponents(string: "https://rickandmortyapi.com/api/character/")!
        let query = URLQueryItem(name: "page", value: "\(page)")
        comps.queryItems = [query]
        var urlRequest = URLRequest(url: comps.url!)

        print("URL request: \(urlRequest)")
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let _ = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }

//            do {
//                let dat = try JSONDecoder().decode([Character].self, from: data)
//                print("Decoded character: \(dat)")
            completion(data, nil)

//            } catch let error {
//                completion(nil, error)
//            }
            return
        }.resume()

    }

    func locationBy(url: String, completion: @escaping (Any?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain:"Passed in String was invalid URL.", code: 0, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let _ = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }

//            do {
//                let dat = try JSONDecoder().decode(Location.self, from: data)
//                print("Decoded location: \(dat)")
            completion(data, nil)

//            } catch let error {
//                completion(nil, error)
//            }
            return
        }.resume()
    }

    func getImageAt(url: String, completion: @escaping (Any?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain:"Passed in String was invalid URL.", code: 0, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let _ = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }

            completion(data, nil)
            return
        }.resume()
    }
}
