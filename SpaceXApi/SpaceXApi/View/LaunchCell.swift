//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var missionImage: UIImageView!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true
        
        launchState.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        launchState.layer.cornerRadius = 10
        launchState.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
