//
//  FirstViewController.swift
//  MobileLabUnlockScreenKit
//
//  Created by Nien Lam on 1/31/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    
    //play audio
    var audioPlayer1 = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()

    // Outlet for status label.
    @IBOutlet weak var statusLabel: UILabel!

    // Outlets for image views to provide visual feedback.
    @IBOutlet weak var feedbackIcon1: UIImageView!
    @IBOutlet weak var feedbackIcon2: UIImageView!
    @IBOutlet weak var feedbackIcon3: UIImageView!

    // Outlet to reset button.
    @IBOutlet weak var resetButton: UIButton!
    
    /////////////////////////////////
    // UNLOCK SEQEUNCE.
    // Used to compare to input pattern.
    let lockPattern = [2, 1, 3]
    /////////////////////////////////

    // Array to capture input from button taps.
    var inputPattern = [Int]()


    // Override setup function already provided by parent class.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
            audioPlayer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "sample1", ofType: "mp3")!))
            audioPlayer1.prepareToPlay()
            
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "sample2", ofType: "mp3")!))
            audioPlayer2.prepareToPlay()
            
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "sample3", ofType: "mp3")!))
            audioPlayer3.prepareToPlay()
        }
        catch{
            print(error)
        }
        
        // Reset screen on app start.
        resetScreen()
    }

    // Helper method to reset the screen.
    func resetScreen() {
        // Initialize status label.
        statusLabel.text = "Enter Sequence"
        
        // Dim feedback icons.
        feedbackIcon1.alpha = 0.2
        feedbackIcon2.alpha = 0.2
        feedbackIcon3.alpha = 0.2
        
        // Reset button is initially hidden.
        resetButton.isHidden = true

        // Flush input pattern.
        inputPattern.removeAll()
    }
    

    // Callback methods for button presses.
    @IBAction func handleButton1(_ sender: UIButton) {
        // Process current pattern with input 1.
        audioPlayer2.play()
        processInputPattern(inputNumber: 1)
    }

    @IBAction func handleButton2(_ sender: UIButton) {
        // Process current pattern with input 2.
        audioPlayer1.play()
        processInputPattern(inputNumber: 2)
    }
    
    @IBAction func handleButton3(_ sender: UIButton) {
        // Process current pattern with input 3.
        audioPlayer3.play()
        processInputPattern(inputNumber: 3)
    }
    
    @IBAction func handleResetButton(_ sender: UIButton) {
        resetScreen()
    }


    // Logic for different stages of the input sequence.
    func processInputPattern(inputNumber: Int) {

        // Append passed in inputNumber into input pattern array.
        inputPattern.append(inputNumber)
        
        // Check where we are in the sequence by inspecting array count.
        if inputPattern.count == 1 {
        
            // Highlight icon 1.
            feedbackIcon1.alpha = 0.7

        } else if inputPattern.count == 2 {

            // Highlight icon 2.
            feedbackIcon2.alpha = 0.7

        } else if inputPattern.count == 3 {

            // Check if pattern matches or need to try again.
            if inputPattern == lockPattern {
                // Highlight icon 3.
                feedbackIcon3.alpha = 0.7

                // Update status message.
                statusLabel.text = "Unlocked"

                // Reveal reset button.
                resetButton.isHidden = false
            } else {
                // Reset feedback icons.
                feedbackIcon1.alpha = 0.2
                feedbackIcon2.alpha = 0.2
                feedbackIcon3.alpha = 0.2

                // Update status message.
                statusLabel.text = "Try Again"
                
                // Flush input pattern.
                inputPattern.removeAll()
            }
        }

    }

}

