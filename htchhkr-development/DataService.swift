//
//  DataService.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 27.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DRIVERS = DB_BASE.child("drivers")
    private var _REF_TRIPS = DB_BASE.child("trips")
    
    var REF_BASE: DatabaseReference
    {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    var REF_DRIVERS: DatabaseReference
    {
        return _REF_DRIVERS
    }
    
    var REF_TRIPS: DatabaseReference
    {
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        
        if isDriver
        {
            REF_DRIVERS.child(uid).updateChildValues(userData)
        }
        else
        {
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
    
    
    
    
    func driverIsAvailable(key : String, handler : @escaping (_ status : Bool?) -> Void) {
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for driver in driverSnapshot
                {
                    if driver.key == key
                    {
                        if driver.childSnapshot(forPath: "isPickupModeEnabled").value as? Bool == true
                        {
                            if driver.childSnapshot(forPath: "driverIsOnTrip").value as? Bool == true
                            {
                                handler(false)
                            }
                            else
                            {
                                handler(true)
                            }
                        }
                    }
                }
            }
        })
    }
    
    func driverIsOnTrip(driverKey: String, handler: @escaping (_ status: Bool?, _ driverKey: String?, _ tripKey: String?) -> Void) {
        
        DataService.instance.REF_DRIVERS.child(driverKey).child("driverIsOnTrip").observe(.value, with: { (driverTripStatusSnapshot) in
            
            if let driverTripStatusSnapshot = driverTripStatusSnapshot.value as? Bool
            {
                if driverTripStatusSnapshot == true
                {
                    DataService.instance.REF_TRIPS.observeSingleEvent(of: .value, with: { (tripSnapshot) in
                        
                        if let tripSnapshot = tripSnapshot.children.allObjects as? [DataSnapshot]
                        {
                            for trip in tripSnapshot
                            {
                                if trip.childSnapshot(forPath: "driverKey").value as? String == driverKey
                                {
                                    handler(true, driverKey, trip.key)
                                }
                                else
                                {
                                    return
                                }
                            }
                        }
                    })
                }
                else
                {
                    handler(false, nil, nil)
                }
            }
        })
    }
    
    func passengerIsOnTrip(passengerKey: String, handler: @escaping (_ status: Bool?, _ driverKey: String?, _ tripKey: String?) -> Void) {
        
        DataService.instance.REF_TRIPS.observe(.value, with: { (tripSnapshot) in
            
            if let tripSnapshot = tripSnapshot.children.allObjects as? [DataSnapshot]
            {
                for trip in tripSnapshot
                {
                    if trip.key == passengerKey
                    {
                        if trip.childSnapshot(forPath: "tripIsAccepted").value as? Bool == true
                        {
                            let driverKey = trip.childSnapshot(forPath: "driverKey").value as? String
                            handler(true, driverKey, trip.key)
                        }
                        else
                        {
                            handler(false, nil, nil)
                        }
                    }
                }
            }
        })
    }
    
    func userIsDriver(userKey: String, handler: @escaping (_ status: Bool) -> Void) {
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (driverSnapshot) in
            
            if let driverSnapshot = driverSnapshot.children.allObjects as? [DataSnapshot]
            {
                for driver in driverSnapshot
                {
                    if driver.key == userKey
                    {
                        handler(true)
                    }
                    else
                    {
                        handler(false)
                    }
                }
            }
        })
    }
}
