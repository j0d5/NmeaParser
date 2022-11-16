//
//  NmeaSentence.swift
//  NmeaParser
//
//  Created by Johannes Steudle on 17.01.18.
//

import CoreLocation

protocol NmeaSentence {
    var rawSentence: [String] { get }

    /// Initialize the object with a raw NMEA sentence.
    /// - Parameter rawSentence: This should contain raw NMEA sentences
    init(rawSentence: [String])

    /// Returns the type of the NMEA sentence.
    func type() -> String

    /// Returns the location as CLLocation parsed from the raw NMEA sentence.
    func parse() -> CLLocation?
}
