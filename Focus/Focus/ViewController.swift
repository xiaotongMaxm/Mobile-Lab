//
//  ViewController.swift
//  Focus
//
//  Created by Xiaotong Ma on 2/18/19.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
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



    @IBOutlet weak var timer: UILabel!
    var countdownTimer: Timer!
    var totalTime = 60
    
    
    @IBOutlet weak var SoundName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var startFocusButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //play one sound
//////////////////////////////////////////////////////////////////////////////////
//        do{
//            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "underwater", ofType: "wav")!))
//            audioPlayer.prepareToPlay()
//        }
//
//        catch{
//            print(error)
//        }
        
        
        //custom startFocusButton
        startFocusButton.layer.cornerRadius = 7
        startFocusButton.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 1.0)
        startFocusButton.layer.shadowColor = UIColor.init(hue: 0.5, saturation: 0.12, brightness: 0.94, alpha: 1.0).cgColor
        startFocusButton.layer.shadowRadius = 40
        startFocusButton.layer.opacity = 1.0
        startFocusButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    

    
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        changeSound()
        updateLabel()
    }
    
    
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


    
    //timer
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timer.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    
    //start button
    @IBAction func startButton(_ sender: UIButton) {
        startTimer()
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        guard let player = player else { return }
        player.pause()
    }
    
//    //prev
//    @IBAction func prev(_ sender: Any) {
//    }
//
//    //next
//    @IBAction func next(_ sender: Any) {
//
//    }
    
    
}

