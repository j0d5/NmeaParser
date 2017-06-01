//
//  NmeaParser.swift
//  NmeaParser
//
//  Created by Johannes Steudle on 31.05.17.
//

import CoreLocation
import Foundation

public class NmeaParser {

    /// RMC is defined as following:
    /// ```
    /// $GPRMC,162614,A,5230.5900,N,01322.3900,E,10.0,90.0,131006,1.2,E,A*13`
    /// $GPRMC,HHMMSS,A,BBBB.BBBB,b,LLLLL.LLLL,l,GG.G,RR.R,DDMMYY,M.M,m,F*PP
    ///      0,     1,2,        3,4,         5,6,   7,   8,     9, 10,11,12
    /// ```
    ///
    /// - TYPE: The type of NMEA data, e.g. RMC, GGA, GSA, GSV
    /// - TIME: The timestamp of the NMEA data
    /// - STATUS: The status of the NMEA data, can be A or W
    /// - LATITUDEDIR: The latitude direction
    /// - LATITUDE: The latitude position
    /// - LONGITUDEDIR: The longitude direction
    /// - LONGITUDE: The longitude position
    /// - SPEED: The speed
    /// - COURSE: The course/direction
    /// - DATE: The date of the NMEA data
    /// - DEVIATION: The deviation of the data
    /// - SIGN: The sign of the deviation data
    /// - SIGNAL: The signal quality with a checksum
    private enum RMCPARAM: Int {
        case TYPE = 0
        case TIME = 1
        case STATUS = 2
        case LATITUDEDIR = 3
        case LATITUDE = 4
        case LONGITUDEDIR = 5
        case LONGITUDE = 6
        case SPEED = 7
        case COURSE = 8
        case DATE = 9
        case DEVIATION = 10
        case SIGN = 11
        case SIGNAL = 12
    }

    /// Expects an NMEA String as parameter and returns a CLLocation object.
    ///
    /// - Parameter data: An NMEA sentence as String
    /// - Returns: An CLLocation object
    public static func parseSentence(data: String) -> CLLocation? {
        print("Input sentence: \(data)")

        let splittedString = data.components(separatedBy: ",")

        if let type = splittedString.first {
            print("NMEA Type \(String(describing: type))")

            switch type {
            case "$GPRMC":
                return self.parseRMC(splittedString)
            case "$GPGGA": fallthrough
            case "$GPGSV": fallthrough
            case "$GPGSA":
                print("Type \(String(describing: type)) not supported yet.")
            default:
                print("Type \(String(describing: type)) unknown.")
            }
        }
        return nil
    }

    private static func parseRMC(_ splittedString: [String]) -> CLLocation? {
        if splittedString.count < 12 {
            print("Invalid RMC string!")
            return nil
        }

        let rawTime = splittedString[RMCPARAM.TIME.rawValue]
        // let rawStatus = splittedString[RMCPARAM.STATUS.rawValue]
        let rawLatitude = (splittedString[RMCPARAM.LATITUDE.rawValue], splittedString[RMCPARAM.LATITUDEDIR.rawValue])
        let rawLongitude = (splittedString[RMCPARAM.LONGITUDE.rawValue], splittedString[RMCPARAM.LONGITUDEDIR.rawValue])
        let rawSpeed = splittedString[RMCPARAM.SPEED.rawValue] // knots
        let rawCourse = splittedString[RMCPARAM.COURSE.rawValue] // degree
        let rawDate = splittedString[RMCPARAM.DATE.rawValue]
        // let rawDeviation = splittedString[RMCPARAM.DEVIATION.rawValue]
        // let rawSignal = splittedString[RMCPARAM.SIGNAL.rawValue]

        let altitude = CLLocationDistance(0)
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(rawLatitude.1)!/100,
                                                longitude: CLLocationDegrees(rawLongitude.1)!/100)
        var course = CLLocationDirection(-1)
        if !rawCourse.isEmpty, let tempCourse = CLLocationDirection(rawCourse) {
            course = tempCourse
        }
        let horizontalAccuracy = CLLocationAccuracy(0)
        let verticalAccuracy = CLLocationAccuracy(0)

        var speed = CLLocationSpeed(-1)
        if !rawSpeed.isEmpty, let tempSpeed = CLLocationSpeed(rawSpeed) {
            speed = tempSpeed
        }

        let concatenatedDate = rawDate + rawTime
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        if rawDate.isEmpty {
            dateFormatter.dateFormat = "hhmmss.SSS" // 025816.16
        } else {
            dateFormatter.dateFormat = "ddMMyyhhmmss.SSS"
        }

        var timestamp = Date()
        if let date = dateFormatter.date(from: concatenatedDate) {
            timestamp = date
        }

        return CLLocation(coordinate: coordinate,
                          altitude: altitude,
                          horizontalAccuracy: horizontalAccuracy,
                          verticalAccuracy: verticalAccuracy,
                          course: course,
                          speed: speed,
                          timestamp: timestamp)
    }
}
