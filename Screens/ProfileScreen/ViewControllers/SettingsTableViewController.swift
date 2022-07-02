//
//  SettingsTableViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 28.06.22.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var settingsData: [ProfileTableData] = [
        .init(title: "Изменить адрес", image: .init(systemName: "house.circle.fill") ?? UIImage()),
        .init(title: "Изменить имя", image: .init(systemName: "person.circle.fill") ?? UIImage()),
        .init(title: "Изменить почту", image: .init(systemName: "envelope.circle.fill") ?? UIImage()),
        .init(title: "Изменить пароль", image: .init(systemName: "key.fill") ?? UIImage())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = ColorsManager.zbzbBackgroundColor
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Профиль"
        navigationController?.navigationBar.tintColor = ColorsManager.zbzbTextColor
        navigationController?.navigationBar.barTintColor = ColorsManager.zbzbBackgroundColor
        
        self.title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22).boldItalic(), NSAttributedString.Key.foregroundColor : ColorsManager.zbzbTextColor]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.settingsData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.update(data: settingsData[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            let controller = presentSettings(data: SettingsContainerView(labelTitle: "Введите новый адрес", firstTextFieldPlaceholder: "Новый адрес", textFieldType: .address))
            present(controller, animated: true)
        case 1:
            let controller = presentSettings(data: SettingsContainerView(labelTitle: "Введите новое имя", firstTextFieldPlaceholder: "Новое имя", textFieldType: .name))
            present(controller, animated: true)
        case 2:
            let controller = presentSettings(data: SettingsContainerView(labelTitle: "Введите новую почту", firstTextFieldPlaceholder: "Новая почта", textFieldType: .email))
            present(controller, animated: true)
        default:
            let controller = presentSettings(data: SettingsContainerView(labelTitle: "Введите новый пароль", firstTextFieldPlaceholder: "Новый пароль", secondTextFieldPlaceholder: "Подтвердите пароль", textFieldType: .password))
            present(controller, animated: true)
        }
    }
    
    private func presentSettings(data: SettingsContainerView) -> SettingsTextFieldsViewController {
        let controller = SettingsTextFieldsViewController()
        controller.updateData(data: data)
        
        return controller
    }
}
