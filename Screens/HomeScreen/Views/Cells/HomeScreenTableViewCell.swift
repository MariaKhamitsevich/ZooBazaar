//
//  HomeScreenTableViewCell.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 5.06.22.
//

import UIKit
import SnapKit

final class HomeScreenTableViewCell: UITableViewCell {
    
    private var arrayOfProducts = [HomeScreenCellElements(name: "Кошки", image: UIImage(named: "cats products")),
                                   HomeScreenCellElements(name: "Собаки", image: UIImage(named: "dogs")),
                                   HomeScreenCellElements(name: "Грызуны", image: UIImage(named: "Mouse"))]
    
    var backendObtainer: BackendObtainer?
    
    weak var controllerDelegate: UIViewController?
    
    //Номер секции в таблице (передается в таблице в методе cellForRowAt)
    var numberOfSectionInTable: Int = 0
    
    // MARK: CollectionView
    private(set) lazy var collectionView: UICollectionView = {
        
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
            let count = backendObtainer?.obtainPopularProducts().count ?? 0
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
            let popularProducts: [ProductSettable] = backendObtainer?.obtainPopularProducts() as? [Product] ?? []
            cell.updateValues(product: popularProducts[indexPath.row])
            return cell
        }
    }
    
    //MARK: CollectionView didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let backendObtainer = backendObtainer else { return }
        let petProvider: PetProvider = PetProvider(petObtainer: backendObtainer)
        
        if numberOfSectionInTable == 0 {
            switch indexPath.item {
            case 0:
                controllerDelegate?.navigationController?.pushViewController(ProductsTableViewController(pets: petProvider, petType: .cats), animated: true)
            case 1:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: petProvider, petType: .dogs), animated: true)
            case 2:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: petProvider, petType: .rodents), animated: true)
            default:
                controllerDelegate?.navigationController?.pushViewController( ProductsTableViewController(pets: petProvider, petType: .cats), animated: true)
            }
        } else {
            let controller = DescriptionViewController()
            let popularProducts: [ProductSettable] = backendObtainer.obtainPopularProducts()
            controller.descriptionVeiw.update(product: popularProducts[indexPath.row])
            controller.descriptionVeiw.currentProduct = popularProducts[indexPath.row]
            controllerDelegate?.present(controller, animated: true)
        }
    }
}
