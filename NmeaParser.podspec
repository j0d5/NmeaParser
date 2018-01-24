#
# Be sure to run `pod lib lint NmeaParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NmeaParser'
  s.version          = '0.1.1'
  s.summary          = 'This is a simple NMEA parser.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This parser is a simple NMEA parser, which currently only supports the NMEA type RMC. It can be used to get the location
data from an NMEA string. Assuming the string will look like this:
"$GPRMC,031849.49,A,5209.028,N,00955.836,E,,,310517,,E*7D"

the NmeaParser will return an CLLocation object that contains the course, longitude and latitude.
                       DESC

  s.homepage         = 'https://github.com/tweetjay/NmeaParser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tweetjay' => 'tweetjay2@gmail.com' }
  s.source           = { :git => 'https://github.com/tweetjay/NmeaParser.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tweetjay2'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NmeaParser/Classes/**/*'

  # s.resource_bundles = {
  #   'NmeaParser' => ['NmeaParser/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreLocation' #'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
