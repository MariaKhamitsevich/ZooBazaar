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
import FirebaseStorageUI
import FirebaseStorage
import ImageAlertAction



final class ProfileViewController: UIViewController {
    
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
        
        tableDelegate.selfController = self
        getUserData()
        
        profileView.profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhotoFromGallery)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let controller = OrdersTableViewController(orderProvider: OrderProvider())
//        controller.orderProvider.callBack = controller.tableView.reloadData
        tableDelegate.tableController = controller
        reloadUserData()
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
            
            profileView.profileImage.sd_setImage(with: user.photoURL)
            
        }
    }
    
    private func reloadUserData() {
        if let user = Auth.auth().currentUser {
            self.profileView.setName(name: user.displayName ?? "")
            self.profileView.setEmail(email: user.email ?? "")
        }
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 
    
    //MARK: Add photo
    @objc private func addPhotoFromGallery() {
        
        let alert = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "Открыть галерею", style: .default, handler: { [weak self] action in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.mediaTypes = ["public.image"]
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self?.present(picker, animated: true)
        })
        
        let camera = UIAlertAction(title: "Сделать фото", style: .default, handler: { [weak self] action in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.mediaTypes = ["public.image"]
            picker.allowsEditing = false
            self?.present(picker, animated: true)
        })
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alert.addAction(gallery)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
   
    //MARK: ImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let user = Auth.auth().currentUser,
              let image = info[.originalImage] as? UIImage,
              let data = image.jpegData(compressionQuality: 0.5) else {
            return
        }

        let metadata = StorageMetadata()

        let storageReference = Storage.storage().reference().child("users/\(user.uid)")
        storageReference.putData(data, metadata: metadata) { [weak self] (metadata, error) in
            if error == nil {
                storageReference.downloadURL { (url, error) in
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.photoURL = url
                    changeRequest.commitChanges { (error) in
                        if let error = error {
                            if let self = self {
                            let alert = ZBZAlert(title: "Загрузка", message: error.localizedDescription, preferredStyle: .alert)
                            alert.getAlert(controller: self)
                            }
                        } else {
                            Swift.debugPrint("Изображение загружено, Url: \(String(describing: url))")
                        }
                    }
                }
            } else {
                Swift.debugPrint("Ошибка \(String(describing: error))")
            }
        }

        profileView.profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    

}

final class ProfileTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
   private var profileData: [ProfileTableData] = [
        .init(title: "Выйти из профиля", image: .init(systemName: "arrowshape.turn.up.backward.fill") ?? UIImage()),
        .init(title: "Настройки", image: .init(systemName: "slider.horizontal.3") ?? UIImage()),
        .init(title: "История заказов", image: .init(systemName: "magazine.fill") ?? UIImage()),
        .init(title: "Связаться с нами", image: .init(systemName: "envelope.circle.fill") ?? UIImage()),
    ]
    
    var returnToRegistration: (() -> Void)?
    var goToSettings: (() -> Void)?
    var selfController: UIViewController?
    var tableController: UITableViewController?
    
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
        case 2:
            if let tableController = tableController {
                selfController?.navigationController?.pushViewController(tableController, animated: true)
            }
        default:
            connectAsAction()
        }
    }
    
    private func connectAsAction() {
        let alert = UIAlertController(title: nil, message: "Выберите способ", preferredStyle: .actionSheet)
        alert.view.tintColor = ColorsManager.zbzbTextColor
 
        
        let telegram = DeviceAppCaller.SocialNetwork.telegram(id: "@mariaKhamitsevich")
        let instagram = DeviceAppCaller.SocialNetwork.instagram(id: "dragunova.mariia")
        let telephone = "+375259369661"
        
        let backAction = UIAlertAction(title: "Отмена", style: .cancel)

        //telegram
        let telegramImage = UIImage(systemName: "paperplane.circle.fill")?.withTintColor(ColorsManager.zbzbTextColor) ?? UIImage()
        let tgImage = telegramImage.sd_resizedImage(with: CGSize(width: 32, height: 32), scaleMode: SDImageScaleMode(rawValue: 10)!) ?? UIImage()
        let telegramAction = UIAlertAction(title: "Telegram", image: tgImage, style: .default) { _ in
            DeviceAppCaller.open(socialNetwork: telegram)
        }
        
        //instagram
        let instagramImage = UIImage(systemName: "camera.circle.fill")?.withTintColor(ColorsManager.zbzbTextColor) ?? UIImage()
        let instImage = instagramImage.sd_resizedImage(with: CGSize(width: 32, height: 32), scaleMode: SDImageScaleMode(rawValue: 10)!) ?? UIImage()
        let instagramAction = UIAlertAction(title: "Instagram", image: instImage, style: .default) { _ in
            DeviceAppCaller.open(socialNetwork: instagram)
        }
        
        //phone
        let phoneImage = UIImage(systemName: "phone.circle.fill")?.withTintColor(ColorsManager.zbzbTextColor) ?? UIImage()
        let phImage = phoneImage.sd_resizedImage(with: CGSize(width: 32, height: 32), scaleMode: SDImageScaleMode(rawValue: 10)!) ?? UIImage()
        let phoneAction = UIAlertAction(title: "Телефон", image: phImage, style: .default) { _ in
            DeviceAppCaller.openPhone(telephone)
        }
        
        alert.addAction(telegramAction)
        alert.addAction(instagramAction)
        alert.addAction(phoneAction)
        alert.addAction(backAction)

        selfController?.present(alert, animated: true)
    }
}


