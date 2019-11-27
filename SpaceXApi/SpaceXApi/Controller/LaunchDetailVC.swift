//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import UIKit

class LaunchDetailVC: UITableViewController {

    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var payloadDeploymentTimeLabel: UILabel!
    @IBOutlet weak var payloadsLabel: UILabel!
    @IBOutlet weak var mecoTimeLabel: UILabel!
    @IBOutlet weak var liftoffTimeLabel: UILabel!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var loadingTimeLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var patchImageView: UIImageView!
    
    static var launchDetail : Launch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        missionNameLabel.text = LaunchDetailVC.launchDetail.missionName
        dateLabel.text = LaunchDetailVC.launchDetail.launchDateLocal
        if LaunchDetailVC.launchDetail.launchSuccess != nil{
            statusLabel.text = LaunchDetailVC.launchDetail.launchSuccess! ? "Succeeded" : "Failed"
        }
        else{
            statusLabel.text = "Upcoming"
        }
        siteLabel.text = LaunchDetailVC.launchDetail.launchSite?.siteNameLong
        rocketLabel.text = LaunchDetailVC.launchDetail.rocket?.rocketName
        payloadsLabel.text = LaunchDetailVC.launchDetail.rocket?.secondStage?.payloads?.first?.payloadID
        
        let timeline = LaunchDetailVC.launchDetail.timeline
        loadingTimeLabel.text = timeline?.propellantPressurization?.intValue()?.formatted
        liftoffTimeLabel.text = timeline?.liftoff?.intValue()?.formatted
        mecoTimeLabel.text = timeline?.engineChill?.intValue()?.formatted
        payloadDeploymentTimeLabel.text = timeline?.payloadDeploy?.intValue()?.formatted
        patchImageView.setImageForUrl(LaunchDetailVC.launchDetail.links?.missionPatch)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: 0)
    }
}
