//
//  SecondViewController.swift
//  Focus
//
//  Created by Xiaotong Ma on 2/18/19.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var countingTime: UILabel!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //update focus time on secondViewController
    func updateFocusTime(){
        
        if totalTime == 0 {
            updateFocusTime()
        }
        
        countingTime.text = "\(totalTime)"
        print(totalTime)
    }
    
    
    //draw a line
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
}
