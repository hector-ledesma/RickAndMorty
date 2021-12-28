//
//  BackendController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation


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
