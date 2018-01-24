# NmeaParser

[![Version](https://img.shields.io/cocoapods/v/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser) [![License](https://img.shields.io/cocoapods/l/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser) [![Platform](https://img.shields.io/cocoapods/p/NmeaParser.svg?style=flat)](http://cocoapods.org/pods/NmeaParser) [![Issues](https://img.shields.io/github/issues/tweetjay/NmeaParser.svg)](https://github.com/tweetjay/NmeaParser/issues) [![Stargazers](https://img.shields.io/github/stars/tweetjay/NmeaParser.svg)](https://github.com/tweetjay/NmeaParser/stargazers) [![TravisCI Status](http://img.shields.io/travis/tweetjay/NmeaParser.svg?style=flat)](https://travis-ci.org/tweetjay/NmeaParser) [![Bitrise Status](https://www.bitrise.io/app/da1c91f49e002323/status.svg?token=xojJPF4vadJ0-eFEvegq8Q&branch=master)](https://www.bitrise.io/app/da1c91f49e002323) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


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
