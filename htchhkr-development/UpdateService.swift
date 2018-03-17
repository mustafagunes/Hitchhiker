//
//  UpdateService.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 5.03.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class UpdateService {
    
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for user in userSnapshot
                {
                    if user.key == Auth.auth().currentUser?.uid
                    {
                        DataService.instance.REF_USERS.child(user.key).updateChildValues([COORDINATE: [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for driver in driverSnapshot
                {
                    if driver.key == Auth.auth().currentUser?.uid
                    {
                        if driver.childSnapshot(forPath: ACCOUNT_PICKUP_MODE_ENABLED).value as? Bool == true
                        {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues([COORDINATE: [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        })
    }
    
    func observeTrips(handler : @escaping(_ coordinateDict : Dictionary<String, AnyObject>?) -> Void) {
        
        DataService.instance.REF_TRIPS.observe(.value, with: { (snapshot) in
            
            if let tripSnapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for trip in tripSnapshot
                {
                    if trip.hasChild(USER_PASSENGER_KEY) && trip.hasChild(TRIP_IS_ACCEPTED)
                    {
                        if let tripDict = trip.value as? Dictionary<String, AnyObject>
                        {
                            handler(tripDict)
                        }
                    }
                }
            }
        })
    }
    
    func updateTripsWithCoordinatesUponRequest() {
        
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for user in userSnapshot
                {
                    if user.key == Auth.auth().currentUser?.uid
                    {
                        if !user.hasChild(USER_IS_DRIVER)
                        {
                            if let userDict = user.value as? Dictionary<String, AnyObject>
                            {
                                let pickupArray = userDict[COORDINATE] as! NSArray
                                let destinationArray = userDict[TRIP_COORDINATE] as! NSArray
                                
                                DataService.instance.REF_TRIPS.child(user.key).updateChildValues([USER_PICKUP_COORDINATE : [pickupArray[0], pickupArray[1]], USER_DESTINATION_COORDINATE : [destinationArray[0], destinationArray[1]], USER_PASSENGER_KEY : user.key, TRIP_IS_ACCEPTED : false])
                            }
                        }
                    }
                }
            }
        })
    }
    
    func acceptTrip(withPassengerKey passengerKey: String, forDriverKey driverKey: String) {
        
        DataService.instance.REF_TRIPS.child(passengerKey).updateChildValues([DRIVER_KEY : driverKey, TRIP_IS_ACCEPTED : true])
        DataService.instance.REF_DRIVERS.child(driverKey).updateChildValues([DRIVER_IS_ON_TRIP : true])
    }
    
    func cancelTrip(withPassengerKey passengerKey: String, forDriverKey driverKey: String?) {
        
        DataService.instance.REF_TRIPS.child(passengerKey).removeValue()
        DataService.instance.REF_USERS.child(passengerKey).child(TRIP_COORDINATE).removeValue()
        
        if driverKey != nil
        {
            DataService.instance.REF_DRIVERS.child(driverKey!).updateChildValues([DRIVER_IS_ON_TRIP: false])
        }
    }
}
