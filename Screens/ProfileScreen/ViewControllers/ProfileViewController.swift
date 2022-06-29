//
//  ProfileViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 16.05.22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView {
        view as! ProfileView
    }
    
    var tableDelegate = ProfileTableDelegate()
            
    override func loadView() {
        view = ProfileView()
        profileView.profileTable.delegate = tableDelegate
        profileView.profileTable.dataSource = tableDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Профиль"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22).boldItalic(), NSAttributedString.Key.foregroundColor : ColorsManager.zbzbTextColor]
  
        profileView.profileTable.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        profileView.profileTable.rowHeight = UITableView.automaticDimension
        profileView.profileTable.separatorStyle = .none
        tableDelegate.returnToRegistration = self.returnToRegistration
        tableDelegate.goToSettings = self.goTosettings
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData()
    }
    
    private func returnToRegistration() {
        navigationController?.pushViewController(RegistrationViewController(), animated: false)
        navigationController?.viewControllers.removeFirst()
    }
    
    private func goTosettings() {
        navigationController?.pushViewController(SettingsTableViewController(), animated: true)
    }
    
  private func getUserData() {
        if let user = Auth.auth().currentUser {
            self.profileView.setName(name: user.displayName ?? "")
            self.profileView.setEmail(email: user.email ?? "")
        }
    }
}

class ProfileTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var profileData: [ProfileTableData] = [
        .init(title: "Выйти из профиля", image: .init(systemName: "arrowshape.turn.up.backward.fill") ?? UIImage()),
        .init(title: "Настройки", image: .init(systemName: "slider.horizontal.3") ?? UIImage()), .init(title: "История заказов", image: .init(systemName: "magazine.fill") ?? UIImage())
    ]
    
    var returnToRegistration: (() -> Void)?
    var goToSettings: (() -> Void)?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.update(data: profileData[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
                try? Auth.auth().signOut()
            returnToRegistration?()
        case 1:
            goToSettings?()
        default:
            print("Do nothing")
        }
    }
}
