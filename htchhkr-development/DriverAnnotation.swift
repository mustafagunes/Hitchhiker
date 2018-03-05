//
//  DriverAnnotation.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 5.03.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import MapKit
import Foundation

class DriverAnnotation : NSObject, MKAnnotation {
    
    var coordinate : CLLocationCoordinate2D
    var key : String
    
    init(coordinate : CLLocationCoordinate2D, withKey key : String) {
        
        self.coordinate = coordinate
        self.key = key

        super.init()
    }
    
    func update(annotationPosition annotation : DriverAnnotation, withCoordinate coordinate : CLLocationCoordinate2D) {
        
        var location = self.coordinate
        
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        
        UIView.animate(withDuration: 0.2) {
            
            self.coordinate = location
        }
    }
}
