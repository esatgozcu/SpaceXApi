//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import Foundation

public class Diameter: Codable {
    
    public let meters: SXNumber?
    public let feet: SXNumber?
    
    enum CodingKeys: String, CodingKey {
        case meters = "meters"
        case feet = "feet"
    }
    
    init(meters: SXNumber?, feet: SXNumber?) {
        self.meters = meters
        self.feet = feet
    }
}
