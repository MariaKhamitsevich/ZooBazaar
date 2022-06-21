//
//  MainTabBar.swift
//  ZooBazaar
//
//  Created by  Maria Khamitsevich on 14.05.22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [UINavigationController(rootViewController: HomeScreenViewController()),
                                UINavigationController(rootViewController: CartViewController()),
                                UINavigationController(rootViewController: MapsViewController()),
                                UINavigationController(rootViewController: RegistrationViewController())]
        
        self.tabBar.barTintColor = ColorsManager.zbzbBackgroundColor
        self.tabBar.backgroundColor = ColorsManager.zbzbBackgroundColor
        self.tabBar.tintColor = ColorsManager.zbzbTextColor
        self.tabBar.unselectedItemTintColor = ColorsManager.unselectedColor
        self.tabBar.items![0].image = UIImage(systemName: "house.fill")
        self.tabBar.items![1].image = UIImage(systemName: "cart.fill")
        self.tabBar.items![2].image = UIImage(systemName: "map.fill")
        self.tabBar.items![3].image = UIImage(systemName: "person.fill")
        self.tabBar.items![0].title = "Магазин"
        self.tabBar.items![1].title = "Корзина"
        self.tabBar.items![2].title = "Карта"
        self.tabBar.items![3].title = "Профиль"
        
    }

}
