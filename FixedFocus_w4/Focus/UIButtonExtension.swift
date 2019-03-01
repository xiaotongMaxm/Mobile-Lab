//
//  UIButtonExtension.swift
//  Focus
//
//  Created by Xiaotong Ma on 2/24/19.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        //transform scale
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.97
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    
}
