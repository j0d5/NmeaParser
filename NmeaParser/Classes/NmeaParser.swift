//
//  NmeaParser.swift
//  NmeaParser
//
//  Created by Johannes Steudle on 31.05.17.
//

import CoreLocation
import Foundation

public class NmeaParser {

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
                let sentence = RmcSentence(rawSentence: splittedString)
                return sentence.parse()
            case "$GPGGA", "$GPGSV", "$GPGSA":
                print("Type \(String(describing: type)) not supported yet.")
            default:
                print("Type \(String(describing: type)) unknown.")
            }
        }
        
        return nil
    }
}
