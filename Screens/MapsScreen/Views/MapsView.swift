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
        
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: self.frame, camera: camera)
//        addSubview(mapView)
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
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
