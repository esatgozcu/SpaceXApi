//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import Foundation

public class Telemetry: Codable {
    
    public let flightClub: String?
    
    enum CodingKeys: String, CodingKey {
        case flightClub = "flight_club"
    }
    
    init(flightClub: String?) {
        self.flightClub = flightClub
    }
}
