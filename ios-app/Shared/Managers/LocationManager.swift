//
//  LocationManager.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var currentLocation: CLLocation? { get }
    func requestLocationPermission()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class LocationManager: NSObject, LocationManagerProtocol {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.shared.error("Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            Logger.shared.warning("Location permission denied")
        case .notDetermined:
            requestLocationPermission()
        @unknown default:
            break
        }
    }
}

