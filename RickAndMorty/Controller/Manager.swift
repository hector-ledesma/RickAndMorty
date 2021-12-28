//
//  Manager.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

class Manager {
    private let backendController: BackendController
    private let storageController: StorageController
    var charCount: Int {
        return storageController.charCount()
    }

    private let characterRouter: Router<CharacterResource>
    private let locationRouter: Router<LocationResource>

    private var currentPage: Int = 1

    init(backendController: BackendController = BackendController(),
         storageController: StorageController = StorageController(),
         characterRouter:   Router<CharacterResource> = Router(),
         locationRouter:   Router<LocationResource> = Router()) {

        self.backendController = backendController
        self.storageController = storageController
        self.characterRouter = characterRouter
        self.locationRouter = locationRouter

    }

    func getCharacterAt(index: Int) -> Character {
        return storageController.getCharacterAt(index: index)
    }

    func getImageDataFor(character: Character, completion: @escaping (Data?, Error?) -> Void) {
        if let data = storageController.getCachedImage(for: character.id) {
            print("Image data found in cache.")
            completion(data, nil)
            return
        }

        characterRouter.get(request: .imageFor(character: character)) { [weak self] (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data to unwrap", code: 0, userInfo: nil))
                return
            }

            guard let self = self else {
                completion(nil, NSError(domain: "No self", code: 0, userInfo: nil))
                return
            }

            self.storageController.cacheImage(data: data, for: character.id)
            completion(data, nil)
        }

    }

    func fetchLocationFrom(character: Character, completion: @escaping (Location?, Error?) -> Void) {
        if let location = storageController.getLocationBy(name: character.location.name) {
            print("Location was in cache")
            completion(location, nil)
            return
        }

        locationRouter.get(request: .url(character.location.url)) { [weak self] (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data to unwrap", code: 0, userInfo: nil))
                return
            }

            guard let self = self else {
                completion(nil, NSError(domain: "No self", code: 0, userInfo: nil))
                return
            }

            do {
                let location: Location = try self.storageController.parseLocation(from: data)
                completion(location, nil)
                return
            } catch let error {
                completion(nil, error)
                return
            }
        }

    }

    func fetchNextPage(completion: @escaping (Bool) -> Void) {

        characterRouter.get(request: .page(number: currentPage)) { [weak self] (data, _, error) in
            if let error = error {
                print("Error on page fetch. \(error)")
                completion(false)
                return
            }

            guard let data = data else {
                print("Error unwrapping data.")
                completion(false)
                return
            }

            guard let self = self else {
                completion(false)
                return
            }

            do {
                try self.storageController.parsePage(from: data)
                self.currentPage += 1
                completion(true)
            } catch let error {
                print("Error parsing characters: \(error)")
                completion(false)
            }
        }
    }




}
