
import UIKit
import SnapKit

struct HomeScreenCellElements {
    let name: String
    let image: UIImage!
    
}

final class CatalogHomeScreenViewCell: UICollectionViewCell {
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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        addAllSubviews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(element: HomeScreenCellElements) {
        nameLabel.text = element.name
        productImage.image = element.image
    }
    
    private func addAllSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(productImage)
    }
    
    private func setAllConstraints() {
        self.nameLabel.snp.updateConstraints { make in
            make.top.equalTo(productImage.snp.bottomMargin).offset(4)
            make.centerX.equalTo(contentView.snp.centerXWithinMargins)
            make.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom)
        }
        self.productImage.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailingMargin)
            make.height.equalTo(UIScreen.main.bounds.width / 2 - 54)
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 56)
        }
    }
}
