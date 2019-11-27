//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageForUrl(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "Default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "Default")
            }
        }
    }
}

extension Int {
    var formatted: String {
        let sign = self >= 0 ? "+" : ""
        return "T" + sign + "\(self)"
    }
}
