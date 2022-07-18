//
//  MapsViewController.swift
//  ZooBazaar
//
//  Created by Maria Khamitsevich on 9.05.22.
//

import UIKit
import GoogleMaps

final class MapsViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var zbzMarkets: [ZBZMarket] = []
    private var markers: [GMSMarker] = []
    
    var mapsView: MapsView {
        view as! MapsView
    }
    
    override func loadView() {
        view = MapsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        loadMarkets()
        createMarketsMarkers()
        centerCamera()
    }

    private func loadMarkets() {
        let firstMarket = ZBZMarket(latitude: 53.926, longitude: 27.517, name: "ZooBazaar", workingHours: "10:00 - 21:00", description: "ТЦ Замок")
        let secondMarket = ZBZMarket(latitude: 53.92, longitude: 27.63, name: "ZooBazaar", workingHours: "09:00 - 22:00", description: "ул. Парниковая")
        let thirdMarket = ZBZMarket(latitude: 53.94, longitude: 27.615, name: "ZooBazaar", workingHours: "09:00 - 22:00", description: "Севастопольский парк")
        let fourthMarket = ZBZMarket(latitude: 53.91, longitude: 27.61, name: "ZooBazaar", workingHours: "09:00 - 20:00", description: "Центральный ботанический сад")

        zbzMarkets.append(contentsOf: [firstMarket, secondMarket, thirdMarket, fourthMarket])
    }
    
    private func createMarketsMarkers() {
        mapsView.mapView.clear()

        for market in zbzMarkets {
            let marker = GMSMarker()
            let latitude = market.latitude
            let longitude = market.longitude
            if let latitude = latitude, let longitude = longitude {
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            marker.map = mapsView.mapView
            marker.userData = market
            marker.isTappable = true
            markers.append(marker)
        }
    }
}


//MARK: GMSMapViewDelegate
extension MapsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let market = marker.userData as? ZBZMarket else { return false }
        
        if let description = market.description,
           let name = market.name,
           let workingHours = market.workingHours {
            
            let message = "\(description)\nВремя работы: \(workingHours)"
            let title = name
            let alert = ZBZAlert(title: title, message: message, preferredStyle: .actionSheet)
            alert.getAlert(controller: self)
        }
            
        return true
    }
    
   

    //MARK: ConfigureMap
    private func configureMap() {
        mapsView.mapView.delegate = self
        mapsView.mapView.isMyLocationEnabled = true
        mapsView.mapView.settings.compassButton = true
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: CenterCamera
    private func centerCamera() {
        if let firstPosition = markers.first?.position {
            var bounds = GMSCoordinateBounds(coordinate: firstPosition, coordinate: firstPosition)
            for marker in markers {
                let currentBounds = GMSCoordinateBounds(coordinate: marker.position, coordinate: marker.position)
                bounds = bounds.includingBounds(currentBounds)
            }
            let positionUpdate = GMSCameraUpdate.fit(bounds, withPadding: 150)
            mapsView.mapView.animate(with: positionUpdate)
        }
    }
}
