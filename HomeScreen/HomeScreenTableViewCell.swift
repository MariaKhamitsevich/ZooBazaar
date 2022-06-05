//
//  HomeScreenTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 5.06.22.
//

import UIKit
import SnapKit

class HomeScreenTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var arrayOfProducts = [HomeScreenCellElements(name: "Кошки", image: UIImage(named: "cats products")),
                           HomeScreenCellElements(name: "Собаки", image: UIImage(named: "dogs")),
                           HomeScreenCellElements(name: "Грызуны", image: UIImage(named: "Mouse"))]
    
    var cats = catsProvider
    var dogs = dogsProvider
    var rodents = rodentsProvider
    var allPets = [catsProvider, dogsProvider, rodentsProvider]
    
    weak var controllerDelegate: UIViewController?
    var numberOfSectionInTable: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 2
        flow.sectionInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.backgroundColor = ColorsManager.zbzbBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(CatalogHomeScreenViewCell.self, forCellWithReuseIdentifier: "CatalogHomeScreenViewCell")
        view.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch numberOfSectionInTable {
        case 0:
        return .init(width: UIScreen.main.bounds.width / 2 - 8, height: 210)
        default:
            return .init(width: UIScreen.main.bounds.width / 2 - 16, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch numberOfSectionInTable {
        case 0:
            return arrayOfProducts.count
        default:
            
            return allPets.flatMap { $0.getPopularProducts() }.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch numberOfSectionInTable {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogHomeScreenViewCell", for: indexPath) as! CatalogHomeScreenViewCell
            cell.updateValues(element: arrayOfProducts[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            
            let popularProducts: [Product] = allPets.flatMap { $0.getPopularProducts()}
            
            cell.updateValues(product: popularProducts[indexPath.row])
            return cell
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogHomeScreenViewCell", for: indexPath) as! CatalogHomeScreenViewCell
         if numberOfSectionInTable == 0 {
        switch indexPath.item {
        case 0:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: cats), animated: true)
        case 1:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: dogs), animated: true)
        case 2:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: rodents), animated: true)
        default:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: cats), animated: true)
        }
         } else {
             let controller = DescroptionViewController()
             let popularProducts: [Product] = allPets.flatMap { $0.getPopularProducts()}
             controller.descriprionVeiw.update(product: popularProducts[indexPath.row])
             controller.descriprionVeiw.currentProduct = popularProducts[indexPath.row]
             controllerDelegate?.present(controller, animated: true)
         }
    }
//    func update(collectionViewController: UICollectionViewController) {
//        self.collectionView = collectionViewController.collectionView
//        
//    }
    
    func setAllConstraints() {
        self.collectionView.snp.updateConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
