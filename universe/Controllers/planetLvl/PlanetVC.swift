//
//  PlanetVC.swift
//  universe
//
//  Created by 1 on 28.01.2021.
//

import UIKit

class PlanetVC: UIViewController {

    @IBOutlet weak var colleectionViewPlanet: UICollectionView!
    var planetModel: Planet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetModel?.delegatePlanetVC = self
        colleectionViewPlanet.dataSource = self
        colleectionViewPlanet.delegate = self

        // Do any additional setup after loading the view.
    }

}

extension PlanetVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return planetModel?.allSatelites.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOfPlanet", for: indexPath) as! CellOfPlanet
        let name = planetModel?.allSatelites[indexPath.item].ID
        cell.labelNameOfSatelite.text = name

        return cell
    }

    func giveSatelites() {
        colleectionViewPlanet.reloadData()
    }
}

extension PlanetVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with: CGFloat = collectionView.frame.size.width
        let heght: CGFloat = 123.0
        return CGSize(width: with, height: heght)
    }
    
}
