//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import Foundation

public class CompositeFairing: Codable {
    
    public let height: CompositeFairingHeight?
    public let diameter: Diameter?
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case diameter = "diameter"
    }
    
    init(height: CompositeFairingHeight?, diameter: Diameter?) {
        self.height = height
        self.diameter = diameter
    }
}
