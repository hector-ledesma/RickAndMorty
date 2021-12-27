//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class ListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    private let manager: Manager = Manager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        manager.fetchNextPage { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationDetailView" {
            guard let detailVC = segue.destination as? LocationDetailViewController else {
                fatalError("Couldn't cast destination to view controller class.")
            }


            detailVC.delegate = self

        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.charCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else {
            fatalError("Boom goes the cell")
        }

        let char = manager.getCharacterAt(index: indexPath.row)
        cell.nameLabel.text = char.name
        cell.statusLabel.text = char.status.rawValue
        cell.speciesLabel.text = char.species

        return cell
    }


}

protocol DetailViewDelegate {
    func locationFor(view detailVC: LocationDetailViewController?)
    func imageFor(view detailVC: LocationDetailViewController?)
}

extension ListViewController: DetailViewDelegate {

    func locationFor(view detailVC: LocationDetailViewController?) {
        guard let ip = tableView.indexPathForSelectedRow else { fatalError("No indexpath to be grabbed?") }

        manager.fetchLocationFrom(character: manager.getCharacterAt(index: ip.row)) { (location, error) in
            if let error = error {
                print("Fetching location failed with error: \(error)")
                return
            }

            guard let location = location else {
                print("Location data couldn't be unwrapped")
                return
            }

            guard let vc = detailVC else {
                print("Detail View Controller no longer available.")
                return
            }

            vc.location = location

        }

    }

    func imageFor(view detailVC: LocationDetailViewController?) {
        guard let ip = tableView.indexPathForSelectedRow else { fatalError("No indexpath to be grabbed?") }

        let char = manager.getCharacterAt(index: ip.row)

        manager.getImageDataFor(character: char) { (data, error) in
            if let error = error {
                print("Fetching image data failed withe rror: \(error)")
                return
            }

            guard let data = data else {
                print("Image data couldn't be unwrapped")
                return
            }

            guard let vc = detailVC else {
                print("Detail View Controller no longer available.")
                return
            }

            vc.imageData = data
        }

        
    }

}
