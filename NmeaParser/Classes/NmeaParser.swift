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
   init() {
      
   }
   
   public static func parseSentence(data: String) -> CLLocation {
      print("Input sentence: \(data)")
      
      let splittedString = data.components(separatedBy: ",")
      
      let type = splittedString.first
      print("NMEA Type \(type)")
      
      if (type?.contains("GPRMC"))! {
         
         let rawCourse = (splittedString[2], splittedString[1])
         print("Raw course: \(rawCourse)")
         
         let rawLongitude = (splittedString[4], splittedString[3])
         print("Raw longitude: \(rawLongitude)")
         
         let rawLatitude = (splittedString[6], splittedString[5])
         print("Raw latitude: \(rawLatitude)")
         
         let altitude = CLLocationDistance(0)
         let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(rawLatitude.1)!, longitude: CLLocationDegrees(rawLongitude.1)!)
         let course = CLLocationDirection(rawCourse.1)!
         let horizontalAccuracy = CLLocationAccuracy(0)
         let verticalAccuracy = CLLocationAccuracy(0)
         let speed = CLLocationSpeed(100)
         let timestamp = Date()
         
         let location = CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: timestamp)
         
         return location
      }
      
      return CLLocation()
   }
}
