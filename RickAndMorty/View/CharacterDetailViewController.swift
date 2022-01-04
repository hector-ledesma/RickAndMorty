//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: DetailViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
    }



}


extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
//            cell.layer.backgroundColor = UIColor.white.cgColor
//            cell.layer.cornerRadius = 10.0
//            cell.layer.shadowColor = UIColor.lightGray.cgColor
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            cell.layer.shadowRadius = 5.0
//            cell.layer.shadowOpacity = 0.3
//            cell.layer.borderWidth = 2.5
//            cell.layer.borderColor = UIColor.lightText.cgColor
//            cell.layer.masksToBounds = false
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let width = screenSize.width - 40
        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: width)
        case 1:
            return CGSize(width: width, height: width*0.3)
        case 2...3:
            return CGSize(width: width, height: width*0.35)
        default:
            return CGSize(width: width, height: width*0.1)
        }

    }


}
