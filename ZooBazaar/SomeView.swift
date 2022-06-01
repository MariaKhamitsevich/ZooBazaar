//
//  SomeView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 21.05.22.
//

import UIKit

class SomeView: UIView {
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.text = "First Frame Label"
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
                
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        label.text = "Second Frame Label"
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true

                
        return label
    }()
    
    private lazy var thirdLabel: LabelWithSubviews = {
        let label = LabelWithSubviews()
        label.backgroundColor = .cyan
        label.numberOfLines = 0
        label.text = "Third Frame Label"
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true

        label.clipsToBounds = false
        label.addSubview(thirdLabelSubview)
                
        return label
    }()
    
    private lazy var thirdLabelSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.isUserInteractionEnabled = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
                
        return view
    }()
    
    private lazy var resultButton: ButtonWithTouchSize = {
        let button = ButtonWithTouchSize()
        button.touchAreaPadding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = ColorsManager.zbzbTextColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        addSubview(resultButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
       let view = super.hitTest(point, with: event)
        if let label = view as? UILabel {
            resultButton.setTitle("\(label.text ?? "Unknown label") \n frame - \(label.frame) \n bounds - \(label.bounds)", for: .normal)
        } else if let view = view {
            resultButton.setTitle("\(view.backgroundColor?.accessibilityName ?? "Unknown view") \n frame - \(String(describing: view.frame) ) \n bounds - \(String(describing: view.bounds))" , for: .normal)
        }
        return view
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let capacity: CGFloat = 20
        let x: CGFloat = 20
        let width: CGFloat = 200
        let heigh: CGFloat = 20
        
        firstLabel.frame = CGRect(x: x, y: 20, width: width, height: heigh)
        
        let secondLabelY = firstLabel.frame.origin.y + firstLabel.frame.height + capacity
        secondLabel.frame = CGRect(x: x, y: secondLabelY, width: width, height: heigh)
        
        let thirdLabelY = secondLabelY + secondLabel.frame.height + capacity
        thirdLabel.frame = CGRect(x: x, y: thirdLabelY, width: width, height: heigh)
        
        thirdLabelSubview.frame = CGRect(x: thirdLabel.bounds.origin.x + 10 , y: 5, width: 100, height: 70)
        resultButton.frame = CGRect(x: (self.frame.origin.x + 50), y: (self.frame.origin.y + self.frame.height - 150), width: (self.frame.origin.x + self.frame.width - 100), height: 120)
    }
}


class LabelWithSubviews: UILabel {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let inside = super.point(inside: point, with: event)
            if !inside {
                for subview in subviews {
                    let pointInSubview = subview.convert(point, from: self)
                    if subview.point(inside: pointInSubview, with: event) {
                        return true
                    }
                }
            }
            return inside
    }
}


