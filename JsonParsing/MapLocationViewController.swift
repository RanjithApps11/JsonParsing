//
//  MapLocationViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit
import GoogleMaps


class MapLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet private weak var pinImageVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var mapCenterPinImage: UIImageView!
    
    @IBAction func setLocationButton(_ sender: Any) {
        
        guard let verify = self.storyboard?.instantiateViewController(withIdentifier: "GetCurrentAddressViewController") as? GetCurrentAddressViewController else {
            return
        }
        verify.selectedAddress = self.addressLabel.text!
        
        DispatchQueue.main.async {
            self.present(verify, animated: true, completion: nil)
        }
        
        
    }
    
    private let locationManager = CLLocationManager()
    private let dataProvider = GoogleDataProvider()
    
    private let searchRadius: Double = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        
        //        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
        //            places.forEach {
        //                let marker = PlaceMarker(place: $0)
        //                marker.map = self.mapView
        //            }
        //        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            //            self.addressLabel.unlock()
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.addressLabel.text = lines.joined(separator: "\n")
            print("address  \(self.addressLabel.text) ")
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            
            if #available(iOS 11.0, *) {
                self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                                    bottom: labelHeight, right: 0)
            } else {
                // Fallback on earlier versions
            }
            
            UIView.animate(withDuration: 0.25) {
                //        self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
                if #available(iOS 11.0, *) {
                    self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
                } else {
                    // Fallback on earlier versions
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
// MARK: - CLLocationManagerDelegate
extension MapLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
        fetchNearbyPlaces(coordinate: location.coordinate)
    }
}
// MARK: - GMSMapViewDelegate
extension MapLocationViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        //        addressLabel.lock()
        if (gesture) {
            //            mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
        }
    }
    //    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
    //        guard let placeMarker = marker as? PlaceMarker else {
    //            return nil
    //        }
    //        guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
    //            return nil
    //        }
    //        infoView.nameLabel.text = placeMarker.place.name
    //        if let photo = placeMarker.place.photo {
    //            infoView.placePhoto.image = photo
    //        } else {
    //            infoView.placePhoto.image = UIImage(named: "Crepe")
    //        }
    //        return infoView
    //    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //        mapCenterPinImage.fadeOut(0.25)
        
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        //        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
}
