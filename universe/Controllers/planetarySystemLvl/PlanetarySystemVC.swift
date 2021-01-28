//
//  PlanetarySystemVC.swift
//  universe
//
//  Created by 1 on 28.01.2021.
//

import UIKit

class PlanetarySystemVC: UIViewController {
    
    @IBOutlet weak var collectionVCPlanetarySystem: UICollectionView!
    
    weak var planetarySystemModel: PlanetarySystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PlanetarySystem(delegate: Galaxy())
        planetarySystemModel?.delegatePlanetarySysVC = self
        collectionVCPlanetarySystem.dataSource = self
        collectionVCPlanetarySystem.delegate = self
        
    }
}

extension PlanetarySystemVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetarySystemModel?.allObjectsOfPS.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOfPlanetarySystemCollection", for: indexPath) as! CellOfPlanetarySystemCollection
        let name = planetarySystemModel?.allObjectsOfPS[indexPath.item].ID
        cell.labelPSObjestName.text = name
        
        return cell

    }

//MARK: - preparing Data For PlanetarySystemCell
    func giveAllObjecetsOfPS() {
        
        if planetarySystemModel?.allStars.count != 0 {
            planetarySystemModel?.allObjectsOfPS = planetarySystemModel!.allStars
        }
        if planetarySystemModel?.allPlanetes.count != 0 {
            planetarySystemModel?.allObjectsOfPS.append(contentsOf: planetarySystemModel!.allPlanetes)
        }
        
        collectionVCPlanetarySystem.reloadData()
    }
}

//MARK: - Transition to PlanetVC
extension PlanetarySystemVC {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PlanetVC") as! PlanetVC
        vc.planetModel = planetarySystemModel?.allPlanetes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Some UI for Cell
extension PlanetarySystemVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with: CGFloat = collectionView.frame.size.width
        let heght: CGFloat = 123.0
        return CGSize(width: with, height: heght)
    }
    
}



