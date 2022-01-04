//
//  CharacterContentViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 1/4/22.
//

import UIKit

class CharacterContentViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var delegate: DetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print("Loaded content controller")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CharacterContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell: UICollectionViewCell?
        switch indexPath.row {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterImageCell", for: indexPath) as? CharacterImageCollectionViewCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterInfoCell", for: indexPath) as? CharacterInfoCollectionViewCell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterLocationCell", for: indexPath) as? CharacterLocationCollectionViewCell
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterLocationCell", for: indexPath) as? CharacterLocationCollectionViewCell
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterEpisodesTitleCell", for: indexPath) as? CharacterEpisodeTitleCollectionViewCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterEpisodeCell", for: indexPath) as? CharacterEpisodeCollectionViewCell
        }

        if let cell = cell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 380, height: 140)
    }


}
