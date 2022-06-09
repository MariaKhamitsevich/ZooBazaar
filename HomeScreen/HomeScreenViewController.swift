
import UIKit

class HomeScreenViewController: UIViewController {
    
    private var homeView: HomeScreenView {
        view as! HomeScreenView
    }
    
    private lazy var tableViewController = HomeTableViewController()
    
    override func loadView() {
        view = HomeScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        addTableController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func addTableController() {
        addChild(tableViewController)
        homeView.addTableConstraints(tableView: tableViewController.tableView)
        tableViewController.didMove(toParent: self)
    }
}
