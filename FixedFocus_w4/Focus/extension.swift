//
//  extension.swift
//  Focus
//
//  Created by Xiaotong Ma on 2/28/19.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 200, g: 200, b: 200)
    static let trackStrokeColor = UIColor.rgb(r: 255, g: 255, b: 255)
    static let pulsatingFillColor = UIColor.rgb(r: 200, g: 200, b: 200)
}
