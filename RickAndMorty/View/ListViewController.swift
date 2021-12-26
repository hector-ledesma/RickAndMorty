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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        controller.get { (data, error) in
            if let error = error {
                print("Got error \(error)")
            }

            print("got data")
            print(data)
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
    }


}

