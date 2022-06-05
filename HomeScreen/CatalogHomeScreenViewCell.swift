
import UIKit
import SnapKit

struct HomeScreenCellElements {
    let name: String
    let image: UIImage!
    
}

class CatalogHomeScreenViewCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorsManager.zbzbTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        return image
    }()
    
    var controller: UITableViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(productImage)
        contentView.backgroundColor = ColorsManager.zbzbBackgroundColor
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(element: HomeScreenCellElements) {
        nameLabel.text = element.name
        productImage.image = element.image
    }
    
    private func setAllConstraints() {
        self.nameLabel.snp.updateConstraints { make in
            make.top.equalTo(productImage.snp.bottomMargin).offset(4)
            make.centerX.equalTo(contentView.snp.centerXWithinMargins)
            make.bottom.equalTo(contentView.snp.bottomMargin).offset(-4)
        }
        self.productImage.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.trailing.equalTo(contentView.snp.trailingMargin).offset(-4)
            make.height.equalTo(150)
            make.width.equalTo(160)
        }
    }
}