
import UIKit
import SnapKit

class HomeScreenView: UIView {
    
    private lazy var wellcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в ZooBazaar!"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24).boldItalic()
        label.numberOfLines = 2
        
        return label
    }()
    
          
    private(set) lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = ColorsManager.zbzbBackgroundColor
        
        return table
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorsManager.zbzbBackgroundColor
        
        addSubview(wellcomeLabel)
        addSubview(tableView)
        
        setAllConstrains()
        [wellcomeLabel, tableView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAllConstrains() {
        self.wellcomeLabel.snp.updateConstraints { make in
            make.topMargin.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
        
        self.tableView.snp.updateConstraints { make in
            make.topMargin.equalTo(wellcomeLabel.snp.bottomMargin).offset(24)
            make.bottom.equalTo(self.snp.bottomMargin)
            make.leadingMargin.equalToSuperview().offset(8)
            make.trailingMargin.equalTo(-8)
        }
    }
}
