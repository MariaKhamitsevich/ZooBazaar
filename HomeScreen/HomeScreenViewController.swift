
import UIKit

protocol BackgroundColorSetable: AnyObject {
    func setBackgroundColor(red: Float, green: Float, blue: Float, alpha: Double)
}

class TableViewSettings: NSObject, UITableViewDelegate, UITableViewDataSource {
    var arrayOfProducts = [HomeScreenCellElements(name: "Products for cats", image: UIImage(named: "cats products")),
                           HomeScreenCellElements(name: "Products for dogs", image: UIImage(named: "dogs")),
                           HomeScreenCellElements(name: "Products for rodents", image: UIImage(named: "Mouse"))]
    
    var cats = catsProvider
    var dogs = dogsProvider
    var rodents = rodentsProvider
    
    
    weak var controllerDelegate: UIViewController?
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell") as! HomeScreenTableViewCell
        cell.updateValues(element: arrayOfProducts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell") as! HomeScreenTableViewCell
        switch indexPath.row {
        case 0:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: cats), animated: true)
        case 1:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: dogs), animated: true)
        case 2:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: rodents), animated: true)
        default:
            controllerDelegate?.navigationController?.pushViewController(cell.controller ?? ProductsTableViewController(pets: cats), animated: true)
        }
        
    }
}

class HomeScreenViewController: UIViewController, BackgroundColorSetable {
    
    var redShadeOfBackground: Float = 255
    var greenShadeOfBackground: Float = 217
    var blueShadeOfBackGround: Float = 221
    var tableDelegate = TableViewSettings()
    private var homeView: HomeScreenView {
        view as! HomeScreenView
    }
    
    
    override func loadView() {
        view = HomeScreenView()
        homeView.tableView.delegate = tableDelegate
        homeView.tableView.dataSource = tableDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        homeView.settingsButton.addTarget(self, action: #selector(runToSettings), for: .touchUpInside)
                      
        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
        tableDelegate.controllerDelegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    @objc func runToSettings(_ sender: UIButton) {
        
        let controller = SettingsViewController()
        controller.backgroundDelegate = self
        controller.view.backgroundColor = view.backgroundColor
        controller.redValue = redShadeOfBackground
        controller.greenValue = greenShadeOfBackground
        controller.blueValue = blueShadeOfBackGround
        present(controller, animated: true)
    }
    
    
    func setBackgroundColor(red: Float, green: Float, blue: Float, alpha: Double) {
        let backgroundColor = UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: alpha)
        view.backgroundColor = backgroundColor
        
        self.redShadeOfBackground = red
        self.greenShadeOfBackground = green
        self.blueShadeOfBackGround = blue
    }
}
