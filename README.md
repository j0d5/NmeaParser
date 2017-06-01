# NmeaParser

[![CI Status](http://img.shields.io/travis/tweetjay/NmeaParser.svg?style=flat)](https://travis-ci.org/tweetjay/NmeaParser)
[![Version](https://img.shields.io/cocoapods/v/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser)
[![License](https://img.shields.io/cocoapods/l/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser)
[![Platform](https://img.shields.io/cocoapods/p/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser)

This parser is a simple NMEA parser, which currently only supports the NMEA type RMC. It can be used to get the location
data from an NMEA string. Assuming the string will look like this:
`"$GPRMC,031849.49,A,5209.028,N,00955.836,E,,,310517,,E*7D"`

the NmeaParser will return an CLLocation object that contains the course, longitude and latitude.

At the moment, this parser is very basic and under development. There is no guarantee that it will always deliver a valid
location.

## Usage

Just call `NmeaParser.parseSentence(data: String) -> CLLocation`.

## Requirements

## Installation

NmeaParser is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NmeaParser"
```

## Author

Johannes Steudle, tweetjay2@gmail.com

## License

NmeaParser is available under the MIT license. See the LICENSE file for more info.
