//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import Foundation

public class SecondStage: Codable {
    
    public let block: SXNumber?
    public let payloads: [Payload]?
    
    enum CodingKeys: String, CodingKey {
        case block = "block"
        case payloads = "payloads"
    }
    
    init(block: SXNumber?, payloads: [Payload]?) {
        self.block = block
        self.payloads = payloads
    }
}
