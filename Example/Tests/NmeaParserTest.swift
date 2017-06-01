import Quick
import Nimble

class TableOfContentsSpec: QuickSpec {
    override func spec() {

        describe("test various string inputs") {
            
            let validTestStrings = [
                "$GPGGA,092750.000,5321.6802,N,00630.3372,W,1,8,1.03,61.7,M,55.2,M,,*76",
                "$GPGSA,A,3,10,07,05,02,29,04,08,13,,,,,1.72,1.03,1.38*0A",
                "$GPGSV,3,1,11,10,63,137,17,07,61,098,15,05,59,290,20,08,54,157,30*70",
                "$GPGSV,3,2,11,02,39,223,19,13,28,070,17,26,23,252,,04,14,186,14*79",
                "$GPGSV,3,3,11,29,09,301,24,16,09,020,,36,,,*76",
                
                "$GPRMC,092750.000,A,5321.6802,N,00630.3372,W,0.02,31.66,280511,,,A*43",
                
                "$GPGGA,092751.000,5321.6802,N,00630.3371,W,1,8,1.03,61.7,M,55.3,M,,*75",
                "$GPGSA,A,3,10,07,05,02,29,04,08,13,,,,,1.72,1.03,1.38*0A",
                "$GPGSV,3,1,11,10,63,137,17,07,61,098,15,05,59,290,20,08,54,157,30*70",
                "$GPGSV,3,2,11,02,39,223,16,13,28,070,17,26,23,252,,04,14,186,15*77",
                "$GPGSV,3,3,11,29,09,301,24,16,09,020,,36,,,*76",
                
                "$GPRMC,092751.000,A,5321.6802,N,00630.3371,W,0.06,31.66,280511,,,A*45"]
            
            it("GGA [0] should return nil") {
                let testLocation = NmeaParser.parseSentence(data: validTestStrings[0])
                expect(testLocation).to(beNil())
            }
            
            it("GSA [1] should return nil") {
                let testLocation = NmeaParser.parseSentence(data: validTestStrings[1])
                expect(testLocation).to(beNil())
            }
            
            it("GSV [2] should return nil") {
                let testLocation = NmeaParser.parseSentence(data: validTestStrings[2])
                expect(testLocation).to(beNil())
            }
            
            it("RMC [5] should return a valid location object") {
                let testLocation = NmeaParser.parseSentence(data: validTestStrings[5])
                
                expect(testLocation?.timestamp.timeIntervalSince1970) == 1306574870
                expect(testLocation?.coordinate.latitude) == 53.216802
                expect(testLocation?.coordinate.longitude) == 6.303372
                expect(testLocation?.speed) == 0.02
                expect(testLocation?.course) == 31.66
            }
            
            it("RMC [11] should return a valid location object") {
                
                let testLocation = NmeaParser.parseSentence(data: validTestStrings[11])
                
                expect(testLocation?.timestamp.timeIntervalSince1970) == 1306574871
                expect(testLocation?.coordinate.latitude) == 53.216802
                expect(testLocation?.coordinate.longitude).to(beCloseTo(6.3034))
                expect(testLocation?.speed) == 0.06
                expect(testLocation?.course) == 31.66
            }
        }
    }
}
