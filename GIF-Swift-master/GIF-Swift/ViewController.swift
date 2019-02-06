//
//  ViewController.swift
//  GIF-Swift
//
//  Created by iOSDevCenters on 12/08/16.
//  Copyright © 2016 iOSDevCenters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    var count = 0
    let items = ["One", "Excuse me", "No", "As god is my witness"]
    
    @IBAction func Button(_ sender: Any) {
        if count > 3 {
            count = 0
        }
        Label.text = items[count]
        count = count + 1
    }
    
    @IBOutlet weak var gif: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        /************************ Load GIF image Using Name ********************/
        
        let jeremyGif = UIImage.gifImageWithName("WhiteHand")
        let imageView = UIImageView(image: jeremyGif)
//        imageView.frame = CGRect(x:-30.0, y:0.0, width: 468.0, height: 896.0)
        imageView.frame = CGRect(x:30.0, y:120.0, width: 320.0, height: 360.0)
        view.addSubview(imageView)
        
        Label2.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

