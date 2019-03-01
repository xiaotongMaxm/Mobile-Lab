//
//  ViewController.swift
//  Focus
//
//  Created by Xiaotong Ma on 2/18/19.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class ViewController: UIViewController {
    
// ------------------------------------------------------------------------------------------
    
    let arraySize = 5
    let soundArray = ["forestRain",
                      "underwater",
                      "storm",
                      "seaside",
                      "outdoor"]
    
    let imageNameArray = ["forest.png",
                          "underwater.png",
                          "cloud.png",
                          "seaside.png",
                          "outdoor.png"]
    
    let stringArray = ["Forest Rain",
                       "UnderWater",
                       "Storm",
                       "Seaside",
                       "Outdoor"]
    
    var player: AVAudioPlayer?
    var currentIndex = -1


// ------------------------------------------------------------------------------------------

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        seconds = Int(sender.value)
        timeLabel.text = String(seconds) + "Seconds"
    }
    
    var seconds = 30
    var timer = Timer()
    


// ------------------------------------------------------------------------------------------
    @IBOutlet weak var SoundName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startFocusButton: UIButton!
    
    
    
// ------------------------------------------------------------------------------------------
//can access shapeLayer
    let shapeLayer = CAShapeLayer()
    //pulsating layer
//    var pulsatingLayer: CAShapeLayer!
    var rippleShape : CAShapeLayer!

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
// ------------------------------------------------------------------------------------------
        //notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        
        
// ------------------------------------------------------------------------------------------
        //custom startFocusButton
        startFocusButton.layer.cornerRadius = 7
        startFocusButton.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 1.0)
        startFocusButton.layer.shadowColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 1.0).cgColor
        startFocusButton.layer.shadowRadius = 40
        startFocusButton.layer.opacity = 1.0
        startFocusButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        //draw a circle
        _ = view.center
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 112, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
//        //pulsatingLayer
//        pulsatingLayer = CAShapeLayer()
//        pulsatingLayer.path = circularPath.cgPath
//        pulsatingLayer.strokeColor = UIColor.clear.cgColor
//        pulsatingLayer.fillColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 0.3).cgColor
//        pulsatingLayer.lineWidth = 20
//        pulsatingLayer.lineCap = CAShapeLayerLineCap.round
//        let screenSize: CGRect = UIScreen.main.bounds
//        let width = screenSize.width
//        let height = screenSize.height
//        imageView.layer.zPosition = CGFloat(1.0)
//        pulsatingLayer.position = CGPoint(x: width/2.0, y: height/2.71)
//        view.layer.addSublayer(pulsatingLayer)
//        animatePulsatingLayer()
        
        //ripple
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width
        let height = screenSize.height
        imageView.layer.zPosition = CGFloat(1.0)
        rippleShape = CAShapeLayer()
        rippleShape.path = circularPath.cgPath
        rippleShape.fillColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 0.6).cgColor
        rippleShape.strokeColor = UIColor.clear.cgColor
        rippleShape.lineWidth = 20
        rippleShape.position = CGPoint(x: width/2.0, y: height/2.71)
        rippleShape.opacity = 0
        view.layer.addSublayer(rippleShape)
        
        
        //track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 4
        trackLayer.lineCap = CAShapeLayerLineCap.round
        //        trackLayer.position = view.center
        trackLayer.position = CGPoint(x: width/2.0, y: height/2.71)
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 1).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        //        shapeLayer.position = view.center
        shapeLayer.position = CGPoint(x: width/2.0, y: height/2.71)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    
//    private func animatePulsatingLayer(){
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//
//        animation.toValue = 1.3
//        animation.duration = 0.8
//        //ease out
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        animation.autoreverses = true
//        animation.repeatCount = Float.infinity
//        pulsatingLayer.add(animation, forKey: "pulsing")
//    }
    
    
    private func animateRippleLayer(){
          let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
          scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
          scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
          let opacityAnim = CABasicAnimation(keyPath: "opacity")
          opacityAnim.fromValue = 1
          opacityAnim.toValue = nil
        
          let animation = CAAnimationGroup()
          animation.animations = [scaleAnim, opacityAnim]
          animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
          animation.duration = 2.0
          animation.repeatCount = Float.infinity
          animation.isRemovedOnCompletion = true
          rippleShape.add(animation, forKey: "rippleEffect")
    }

    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 20
        basicAnimation.isRemovedOnCompletion = false
        //add animation to shapeLayer
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }


    
    
// ------------------------------------------------------------------------------------------
    func changeSound(){
        // Update content index.,
        nextIndex()
        
        // Play sound.
        if !soundArray[currentIndex].isEmpty {
            playSoundMP3(filename: soundArray[currentIndex])
        }
        
        // Update image if string is not empty
        if imageNameArray[currentIndex].isEmpty {
            imageView.image = nil
        } else {
            imageView.image = UIImage(named: imageNameArray[currentIndex])
        }
        
    }
    
    func updateLabel(){
        // Update label.
        SoundName.text = stringArray[currentIndex]
    }
    
    
    func nextIndex() {
            currentIndex = (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
    }
    
    
    // Play a mp3 sound file.
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }


// ------------------------------------------------------------------------------------------
//    //timer
//    func startTimer() {
//        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//    }
//
//    @objc func updateTime() {
//        timer.text = "\(timeFormatted(totalTime))"
//
//        if totalTime != 0 {
//            totalTime -= 1
//        } else {
//            endTimer()
//        }
//    }
//
//    func endTimer() {
//        countdownTimer.invalidate()
//    }
//    
//    func timeFormatted(_ totalSeconds: Int) -> String {
//        let seconds: Int = totalSeconds % 60
//        let minutes: Int = (totalSeconds / 60) % 60
//        //     let hours: Int = totalSeconds / 3600
//        return String(format: "%02d:%02d", minutes, seconds)
//    }

    
    
// ------------------------------------------------------------------------------------------
    //start button
    @IBAction func startButton(_ sender: UIButton) {
//        startTimer()
        sender.pulsate()
        animateCircle()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
    }
    
    
    
// ------------------------------------------------------------------------------------------
    @objc func counter (){
        seconds -= 1
        print(seconds)
        timeLabel.text = String(seconds) + "Seconds"
        
        let content = UNMutableNotificationContent()
        content.title = "Focus finished!"
        content.subtitle = "20 seconds focus finished!👏👏👏"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        if(seconds == 0){
            timer.invalidate()
        }
    }
    
    
    
// ------------------------------------------------------------------------------------------
    @IBAction func play(_ sender: UIButton) {
        guard let player = player else { return }
        player.pause()
    }
    
    
    @objc private func handleTap(){
        changeSound()
        updateLabel()
//        animatePulsatingLayer()
        animateRippleLayer()
    }
}



class CustomSlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: 20.0, height: 10.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    
    
}
