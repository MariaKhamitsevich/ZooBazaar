
import UIKit


class TableViewSettings: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var titlesForSections = ["Каталог", "Популярное"]

    weak var controllerDelegate: UIViewController?
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HomeScreenHeaders()
        view.title = titlesForSections[section]
        return view
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell", for: indexPath) as! HomeScreenTableViewCell
        cell.numberOfSectionInTable = indexPath.section
        cell.controllerDelegate = self.controllerDelegate
        return cell
    }
}

class HomeScreenViewController: UIViewController {
    
    
    var tableViewDelegate = TableViewSettings()
    private var homeView: HomeScreenView {
        view as! HomeScreenView
    }
    
    
    override func loadView() {
        view = HomeScreenView()
        homeView.tableView.delegate = tableViewDelegate
        homeView.tableView.dataSource = tableViewDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
//        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.rowHeight = 220
        homeView.tableView.separatorStyle = .none
        homeView.tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
        tableViewDelegate.controllerDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
}
