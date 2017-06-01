//
//  NmeaParser.swift
//  Pods
//
//  Created by Johannes on 31.05.17.
//
//

import Foundation
import CoreLocation

public class NmeaParser {
    
    public static func parseSentence(data: String) -> CLLocation {
        print("Input sentence: \(data)")
        
        let splittedString = data.components(separatedBy: ",")
        
        let type = splittedString.first
        print("NMEA Type \(String(describing: type))")
        
        if (type?.contains("GPRMC"))! {
            let rawCourse = (splittedString[2], splittedString[1])
            let rawLongitude = (splittedString[4], splittedString[3])
            let rawLatitude = (splittedString[6], splittedString[5])
            // print("Raw latitude: \(rawLatitude)")
            // print("Raw longitude: \(rawLongitude)")
            // print("Raw course: \(rawCourse)")
            
            let altitude = CLLocationDistance(0)
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(rawLatitude.1)!/100,
                                                    longitude: CLLocationDegrees(rawLongitude.1)!/100)
            let course = CLLocationDirection(rawCourse.1)!
            let horizontalAccuracy = CLLocationAccuracy(0)
            let verticalAccuracy = CLLocationAccuracy(0)
            let speed = CLLocationSpeed(100)
            let timestamp = Date()
            
            let location = CLLocation(coordinate: coordinate,
                                      altitude: altitude,
                                      horizontalAccuracy: horizontalAccuracy,
                                      verticalAccuracy: verticalAccuracy,
                                      course: course,
                                      speed: speed,
                                      timestamp: timestamp)
            
            return location
        } else {
            print("Type \(String(describing: type)) unknown or not supported yet.")
        }
        
        return CLLocation()
    }
}
