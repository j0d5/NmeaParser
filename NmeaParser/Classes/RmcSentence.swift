//
//  RmcSentence.swift
//  NmeaParser
//
//  Created by Johannes Steudle on 17.01.18.
//

import CoreLocation

public class RmcSentence: NmeaSentence {

    var rawSentence: [String]

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
    enum Param: Int {
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

    required public init(rawSentence: [String]) {
        self.rawSentence = rawSentence
    }

    func type() -> String {
        return "$GPRMC"
    }

    func parse() -> CLLocation? {
        let splittedString = self.rawSentence

        if splittedString.count < 12 {
            print("Invalid RMC string!")
            return nil
        }

        let rawTime = splittedString[RmcSentence.Param.TIME.rawValue]
        let rawLatitude = (splittedString[RmcSentence.Param.LATITUDE.rawValue],
                           splittedString[RmcSentence.Param.LATITUDEDIR.rawValue])
        let rawLongitude = (splittedString[RmcSentence.Param.LONGITUDE.rawValue],
                            splittedString[RmcSentence.Param.LONGITUDEDIR.rawValue])
        let rawSpeed = splittedString[RmcSentence.Param.SPEED.rawValue] // knots
        let rawCourse = splittedString[RmcSentence.Param.COURSE.rawValue] // degree
        let rawDate = splittedString[RmcSentence.Param.DATE.rawValue]

        let latitudeInDegree = convertLatitudeToDegree(with: rawLatitude.1)
        print("Latitude in degrees: \(latitudeInDegree)")

        let longitudeInDegree = convertLongitudeToDegree(with: rawLongitude.1)
        print("Longitude in degrees: \(longitudeInDegree)")

        let coordinate = CLLocationCoordinate2D(latitude: latitudeInDegree,
                                                longitude: longitudeInDegree)
        var course = CLLocationDirection(-1)
        if !rawCourse.isEmpty, let tempCourse = CLLocationDirection(rawCourse) {
            course = tempCourse
        }

        var speed = CLLocationSpeed(-1)
        if !rawSpeed.isEmpty {
            if #available(iOS 10.0, *) {
                let speedInMs = Measurement(value: Double(rawSpeed)!,
                                            unit: UnitSpeed.knots)
                                .converted(to: UnitSpeed.metersPerSecond)
                speed = CLLocationSpeed(speedInMs.value)
            } else {
                speed = CLLocationSpeed(Double(rawSpeed)! * 0.514)
            }
        }

        let concatenatedDate = rawDate + rawTime
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        if rawDate.isEmpty {
            dateFormatter.dateFormat = "hhmmss.SSS" // 025816.16
        } else {
            dateFormatter.dateFormat = "ddMMyyHHmmss.SSS"
        }

        var timestamp = Date()
        if let date = dateFormatter.date(from: concatenatedDate) {
            timestamp = date
        }

        let altitude = CLLocationDistance(0)
        let horizontalAccuracy = CLLocationAccuracy(0)
        let verticalAccuracy = CLLocationAccuracy(0)

        return CLLocation(coordinate: coordinate,
                          altitude: altitude,
                          horizontalAccuracy: horizontalAccuracy,
                          verticalAccuracy: verticalAccuracy,
                          course: course,
                          speed: speed,
                          timestamp: timestamp)
    }

    /// Format XXYY.ZZZZ -> XX° + (YY.ZZZZ / 60)°
    ///
    /// - stringValue
    ///
    /// @return
    func convertLatitudeToDegree(with stringValue: String) -> Double {
        return Double(stringValue.prefix(2))! +
            Double(stringValue.suffix(from: String.Index(encodedOffset: 2)))! / 60
    }

    /// Format XXYY.ZZZZ -> XX° + (YY.ZZZZ / 60)°
    ///
    /// - stringValue
    ///
    /// @return
    func convertLongitudeToDegree(with stringValue: String) -> Double {
        return Double(stringValue.prefix(3))! +
            Double(stringValue.suffix(from: String.Index(encodedOffset: 3)))! / 60
    }

}
