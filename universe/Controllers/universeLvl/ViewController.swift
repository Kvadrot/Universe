//
//  ViewController.swift
//  universe
//
//  Created by 1 on 14.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var universeModel = Universe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        universeModel.delegate = self
        universeModel.timer.start()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return universeModel.allGalaxies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellObject", for: indexPath) as! CellSpaceObjectVC
        let name = universeModel.allGalaxies[indexPath.item].ID
        
        cell.labelForObejectName.text = name
        return cell
    }

    func giveUniverse() {
        collectionView.reloadData()
    }
}


extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GalaxyVC") as! GalaxyVC
        vc.galaxyModel = universeModel.allGalaxies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with: CGFloat = collectionView.frame.size.width
        let heght: CGFloat = 123.0
        return CGSize(width: with, height: heght)
    }
    
}
