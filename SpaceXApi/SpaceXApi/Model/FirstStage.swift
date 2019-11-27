//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import Foundation

public class FirstStage: Codable {
    
    public let cores: [FirstStageCore]?
    
    enum CodingKeys: String, CodingKey {
        case cores = "cores"
    }
    
    init(cores: [FirstStageCore]?) {
        self.cores = cores
    }
}
