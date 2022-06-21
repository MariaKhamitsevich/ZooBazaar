
import UIKit
import SnapKit

class HomeScreenView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchScreen")
        image.alpha = 0.3
        
        return image
    }()
    
    private lazy var wellcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в ZooBazaar!"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24).boldItalic()
        label.numberOfLines = 2
        
        return label
    }()
 
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorsManager.zbzbBackgroundColor
        
        addSubview(logoImageView)
        addSubview(wellcomeLabel)
        setAllConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTableConstraints(tableView: UITableView) {
        addSubview(tableView)
        tableView.snp.updateConstraints { make in
            make.topMargin.equalTo(wellcomeLabel.snp.bottomMargin)
            make.leadingMargin.equalTo(self.layoutMarginsGuide.snp.leading).offset(8)
            make.trailingMargin.equalTo(self.layoutMarginsGuide.snp.trailing).offset(-8)
            make.bottom.equalTo(self.layoutMarginsGuide.snp.bottom).offset(90)
        }
    }
    
    private func setAllConstrains() {
        self.logoImageView.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        self.wellcomeLabel.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
    }
}
