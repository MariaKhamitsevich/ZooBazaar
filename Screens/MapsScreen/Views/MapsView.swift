//
//  MapsView.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import SnapKit
import GoogleMaps

class MapsView: UIView {
    
    private(set) lazy var mapView: GMSMapView = {
        let map = GMSMapView()
        
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsManager.zbzbBackgroundColor
        addAllSubviews()
        setAllConstraints()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addAllSubviews() {
        addSubview(mapView)
    }
    private func setAllConstraints() {
        mapView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
