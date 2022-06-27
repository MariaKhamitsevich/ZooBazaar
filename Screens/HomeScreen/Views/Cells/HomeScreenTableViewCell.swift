//
//  HomeScreenTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 5.06.22.
//

import UIKit
import SnapKit

class HomeScreenTableViewCell: UITableViewCell {
    
    var arrayOfProducts = [HomeScreenCellElements(name: "Кошки", image: UIImage(named: "cats products")),
                           HomeScreenCellElements(name: "Собаки", image: UIImage(named: "dogs")),
                           HomeScreenCellElements(name: "Грызуны", image: UIImage(named: "Mouse"))]
    var catsObtainer: BackendObtainer = BackendObtainer(pet: .cats)
    var dogsObtainer: BackendObtainer = BackendObtainer(pet: .dogs)
    var rodentsObtainer: BackendObtainer = BackendObtainer(pet: .rodents)
    
//    var catsProvider: PetProvider?
//    var dogsProvider: PetProvider?
//    var rodentsProvider: PetProvider?
    
    
//    var cats = catsProvider
//    var dogs = dogsProvider
//    var rodents = rodentsProvider
    var allPets: [BackendObtainer] {
        [catsObtainer, dogsObtainer, rodentsObtainer]
    }
    
//    func getProviders() {
//        self.catsProvider = PetProvider(petObtainer: catsObtainer)
//        self.dogsProvider = PetProvider(petObtainer: dogsObtainer)
//        self.rodentsProvider = PetProvider(petObtainer: rodentsObtainer)
//
//        self.allPets = [catsObtainer, dogsObtainer, rodentsObtainer]
//    }
    
    
    weak var controllerDelegate: UIViewController?
    
    //Номер секции в таблице (передается в таблице в методе cellForRowAt)
    var numberOfSectionInTable: Int = 0
    
    // MARK: CollectionView
    private lazy var collectionView: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 1
        flow.sectionInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(CatalogHomeScreenViewCell.self, forCellWithReuseIdentifier: "CatalogHomeScreenViewCell")
        view.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        
        return view
    }()
    
    private lazy var dots: UIPageControl = {
        let dots = UIPageControl()
        dots.backgroundColor = .clear
        dots.pageIndicatorTintColor = ColorsManager.unselectedColor
        dots.currentPageIndicatorTintColor = ColorsManager.zbzbTextColor
        
        return dots
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.addSubview(dots)
        contentView.backgroundColor = .clear
        
        catsObtainer.callBack = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        dogsObtainer.callBack = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        rodentsObtainer.callBack = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        setAllConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set all constraints
    func setAllConstraints() {
        self.collectionView.snp.updateConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        self.dots.snp.updateConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(collectionView.layoutMarginsGuide.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: Extention
extension HomeScreenTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (collectionView.contentOffset.x / collectionView.frame.width + 0.1)
                .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch numberOfSectionInTable {
        case 0:
            return .init(width: UIScreen.main.bounds.width / 2 - 16, height: UIScreen.main.bounds.height / 3.5)
        default:
            return .init(width: UIScreen.main.bounds.width / 2 - 16, height: UIScreen.main.bounds.height / 3.4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch numberOfSectionInTable {
        case 0:
            let count = arrayOfProducts.count
            dots.numberOfPages = Int(round(Double(count) / 2))
            return count
        default:
            let count = allPets.flatMap { $0.obtainPopularProducts() }.count
            dots.numberOfPages = Int(round(Double(count) / 2))
            return count
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
            let popularProducts: [Product] = allPets.flatMap { $0.obtainPopularProducts() }
            cell.updateValues(product: popularProducts[indexPath.row])
            return cell
        }
    }
    
    //MARK: CollectionView didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catsProvider = PetProvider(petObtainer: catsObtainer)
        let dogsProvider = PetProvider(petObtainer: dogsObtainer)
        let rodentsProvider = PetProvider(petObtainer: rodentsObtainer)
        
        
        if numberOfSectionInTable == 0 {
            switch indexPath.item {
            case 0:
                controllerDelegate?.navigationController?.pushViewController(ProductsTableViewController(pets: catsProvider), animated: true)
            case 1:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: dogsProvider), animated: true)
            case 2:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: rodentsProvider), animated: true)
            default:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: catsProvider), animated: true)
            }
        } else {
            let controller = DescroptionViewController()
            let popularProducts: [Product] = allPets.flatMap { $0.obtainPopularProducts() }
            controller.descriprionVeiw.update(product: popularProducts[indexPath.row])
            controller.descriprionVeiw.currentProduct = popularProducts[indexPath.row]
            controllerDelegate?.present(controller, animated: true)
        }
    }
}
