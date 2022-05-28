
import UIKit
import SnapKit

class SettingsView: UIView {
    
    //MARK: Properties
    // InformationStackViews
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(telephoneLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var telephoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Telephone: +375251234567"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: zoobazaar@zoobazaar.by"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address: Pershaya str., 1"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    //ColorLabelsStack
    private lazy var colorsLabelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(redTitleLabel)
        stackView.addArrangedSubview(greenTitleLabel)
        stackView.addArrangedSubview(blueTitleLabel)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var redTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Red"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var greenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Green"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var blueTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Blue"
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    // colorValueStack
    private lazy var colorsValueStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(redValueLabel)
        stackView.addArrangedSubview(greenValueLabel)
        stackView.addArrangedSubview(blueValueLabel)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var redValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(redSlider.value))
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var greenValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(greenSlider.value))
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var blueValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(blueSlider.value))
        label.textColor = ColorsManager.zbzbTextColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var colorSlidersStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(redSlider)
        stackView.addArrangedSubview(greenSlider)
        stackView.addArrangedSubview(blueSlider)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var redSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 255
        slider.tag = 0
        slider.isContinuous = true
        slider.isEnabled = true
        slider.isUserInteractionEnabled = true
        
        return slider
    }()
    
    private lazy var greenSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 217
        slider.tag = 1
        slider.isContinuous = true
        slider.isEnabled = true
        slider.isUserInteractionEnabled = true
        
        return slider
    }()
    
    private lazy var blueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 221
        slider.tag = 2
        slider.isContinuous = true
        slider.isEnabled = true
        slider.isUserInteractionEnabled = true
        
        return slider
    }()
    
    var red: Float {
        redSlider.value
    }
    var green: Float {
        greenSlider.value
    }
    var blue: Float {
        blueSlider.value
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorsManager.zbzbBackgroundColor
        addSubview(informationStackView)
        addSubview(colorsLabelsStack)
        addSubview(colorsValueStack)
        addSubview(colorSlidersStack)
        redValueLabel.text = String(Int(redSlider.value))
        greenValueLabel.text = String(Int(greenSlider.value))
        blueValueLabel.text = String(Int(blueSlider.value))
        
        
        setAllConstraints()
        
        for subview in colorSlidersStack.subviews {
            if let subview = subview as? UISlider {
                subview.addTarget(self, action: #selector(slidersAction), for: .valueChanged)
                
            }
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setAllConstraints()
    private func setAllConstraints() {
        self.informationStackView.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(54)
            make.leading.equalToSuperview().offset(24)
            for label in informationStackView.arrangedSubviews {
                label.snp.updateConstraints { make in
                    make.height.equalTo(label).offset(16)
                }
            }
        }
        
        self.colorsLabelsStack.snp.updateConstraints { make in
            make.top.equalTo(informationStackView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            for label in colorsLabelsStack.arrangedSubviews {
                label.snp.updateConstraints { make in
                    make.height.equalTo(16)
                }
            }
        }
        self.colorsValueStack.snp.updateConstraints { make in
            make.top.equalTo(informationStackView.snp.bottom).offset(32)
            make.leading.equalTo(colorsLabelsStack.snp_trailingMargin).offset(24)
            for label in colorsValueStack.arrangedSubviews {
                label.snp.updateConstraints { make in
                    make.height.equalTo(16)
                    make.width.equalTo(40)
                }
            }
        }
        self.colorSlidersStack.snp.updateConstraints { make in
            make.top.equalTo(colorsValueStack.snp.top)
            make.leading.equalTo(colorsValueStack.snp_trailingMargin).offset(24)
            make.trailing.equalToSuperview().offset(-24)
            for label in colorSlidersStack.arrangedSubviews {
                label.snp.updateConstraints { make in
                    make.height.equalTo(16)
                }
            }
        }
    }
    
    // MARK: setColor()
    private func setColor() {
        backgroundColor = UIColor(
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255),
            alpha: 1)
    }
    
    @objc func slidersAction(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        
        setColor()
        switch slider.tag {
        case 0: redValueLabel.text = String(Int(redSlider.value))
        case 1: greenValueLabel.text = String(Int(greenSlider.value))
        case 2: blueValueLabel.text = String(Int(blueSlider.value))
        default: break
        }
    }
}

extension SettingsView {
    func setColors(red: Float, green: Float, blue: Float) {
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        redValueLabel.text = String(Int(red))
        greenValueLabel.text = String(Int(green))
        blueValueLabel.text = String(Int(blue))
        
    }
}
