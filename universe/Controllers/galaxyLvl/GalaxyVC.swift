//
//  GalaxyVC.swift
//  universe
//
//  Created by 1 on 24.01.2021.
//

import UIKit

class GalaxyVC: UIViewController {

    @IBOutlet weak var collectionViewOfGalaxyVC: UICollectionView!

    weak var galaxyModel: Galaxy?
    weak var universeModel: Universe?// = Universe()

    override func viewDidLoad() {
        super.viewDidLoad()

        //GalaxyVC()
        galaxyModel?.heroAlertHandler = { [weak self] in
            self?.heroAlert()
        }
        
        galaxyModel?.giveAllHolesAndSystemesHandler = { [weak self] in
            self?.giveAllHolesAndSystemes()
        }
    
        universeModel?.delegateGalaxyVC = self
        collectionViewOfGalaxyVC.dataSource = self
        collectionViewOfGalaxyVC.delegate = self
    }
}

extension GalaxyVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galaxyModel?.allHolesAndSystemes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOfGalaxyCollection", for: indexPath) as! CellOfGalaxyCollection
        let name = galaxyModel?.allHolesAndSystemes[indexPath.item].ID
        cell.labelForPlanetarySysName.text = name
        
        return cell
    }
//MARK: - preparing Data For GalaxyCell
    func giveAllHolesAndSystemes() {
        
        if galaxyModel?.allPlanetarySystemes.count != 0 {
            galaxyModel?.allHolesAndSystemes = galaxyModel!.allPlanetarySystemes
        }
        if galaxyModel?.allBlackHoles.count != 0 {
            galaxyModel?.allHolesAndSystemes.append(contentsOf: galaxyModel!.allBlackHoles)
        }

        collectionViewOfGalaxyVC.reloadData()
    }
    
}

extension GalaxyVC {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PlanetarySystemVC") as! PlanetarySystemVC
        vc.planetarySystemModel = galaxyModel?.allHolesAndSystemes[indexPath.row] as? PlanetarySystem

        if vc.planetarySystemModel?.totalWeight != nil {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Alert before MergeringGalaxies
extension GalaxyVC {

    func heroAlert() {

        let alert = UIAlertController(title: "Leave", message: "You are in danger, the Galaxy you are in, is close to be mergered, to save yourself, plese click on button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "To survive", style: .cancel, handler: { action in
            
            let parentVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
}

extension GalaxyVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let with: CGFloat = collectionView.frame.size.width
        let heght: CGFloat = 123.0

        return CGSize(width: with, height: heght)
    }
    
}
