//
//  Location.swift
//  md4
//
//  Created by david Myers on 8/4/18.
//  Copyright © 2018 david Myers. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationError: Error {
    case FailError(String)
}
typealias LocationCompletion = (_ location:CLLocation?, _ err:LocationError?)->()


class Location: NSObject,CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager?
    var geoCoder:CLGeocoder?
    var locationCompletion:LocationCompletion?

    func findLocation(_ completion:@escaping LocationCompletion){
        locationManager = CLLocationManager.init()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        locationCompletion = completion
        locationManager?.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        locationCompletion?(currentLocation,nil)
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion?(nil,LocationError.FailError("Fail"))
    }
}
