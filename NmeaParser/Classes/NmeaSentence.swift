//
//  File.swift
//  Nimble
//
//  Created by Johannes on 17.01.18.
//
import CoreLocation

protocol NmeaSentence {
    var rawSentence: [String] { get }
    
    init(rawSentence: [String])
    
    func type() -> String
    
    func parse() -> CLLocation?
}
