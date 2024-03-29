//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var topColor: UIColor = .black
    @IBInspectable var bottomColor: UIColor = .white
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (layer as? CAGradientLayer)?.colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
