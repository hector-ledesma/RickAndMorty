//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class ListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    let controller: BackendController = BackendController()
    var characters: [Character] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        controller.get { (data, error) in
            if let error = error {
                print("Got error \(error)")
            }

            guard let data = data as? [Character] else {
                print("Couldn't cast data")
                return
            }
            self.characters = data
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationDetailView" {
            guard let detailVC = segue.destination as? LocationDetailViewController else {
                fatalError("Couldn't cast destination to view controller class.")
            }
            guard let ip = tableView.indexPathForSelectedRow else {
                fatalError("No indexpath to be grabbed?")
            }

            detailVC.character = self.characters[ip.row]
            detailVC.controller = self.controller

        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else {
            fatalError("Boom goes the cell")
        }

        let char = characters[indexPath.row]
        cell.nameLabel.text = char.name
        cell.statusLabel.text = char.status.rawValue
        cell.speciesLabel.text = char.species

        return cell
    }


}

