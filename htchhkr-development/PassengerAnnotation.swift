//
//  PassengerAnnotation.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 6.03.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation : NSObject, MKAnnotation {

    dynamic var coordinate : CLLocationCoordinate2D
    var key : String
    
    init(coordinate : CLLocationCoordinate2D, key : String) {
        
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
