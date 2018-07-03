//
//  ViewController.swift
//  day1
//
//  Created by Brian Xu on 2/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftSpinner

class ViewController: UIViewController {
    
    @IBOutlet weak var p1button: UIButton!
    @IBOutlet weak var p2button: UIButton!
    @IBOutlet weak var p2scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var p1score = 0
    var p2score = 0
    
    var p1startColor: UIColor!
    var p2startColor: UIColor!
    
    let maxDefaults = "previousMax"
    
    lazy var player: AVAudioPlayer = {
        return AVAudioPlayer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 50.0))
        if UserDefaults.standard.object(forKey: maxDefaults) != nil {
            GameState.maxScore = UserDefaults.standard.integer(forKey: maxDefaults)
        }
        p1startColor = p1button.backgroundColor!
        p2startColor = p2button.backgroundColor!
        
        p2scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func p1buttonTapped(_ sender: UIButton) {
        p1score += 1
        p1button.setTitle(String(p1score), for: .normal)
        darkenColor(button: p1button)
        player.play()
        
        if p1score == GameState.maxScore {
            p1button.setTitle("WINNER", for: .disabled)
            gameFinish()
        }
    }
    
    @IBAction func p2buttonTapped(_ sender: UIButton) {
        p2score += 1
        p2button.setTitle(String(p2score), for: .normal)
        darkenColor(button: p2button)
        player.play()
        
        if p2score == GameState.maxScore {
            p2button.setTitle("WINNER", for: .disabled)
            gameFinish()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        if GameState.firstGame {
            guard let soundPath = Bundle.main.path(forResource: "tap", ofType: "wav") else {
                return
            }
            let soundURL = NSURL(fileURLWithPath: soundPath) as URL
            player = try! AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.wav.rawValue)
            
            resetButton.setTitle("RESET", for: .normal)
            GameState.firstGameStart()
        }
        player.prepareToPlay()
        disableMenu()
        
        p1score = 0
        p2score = 0
        resetScore(button: p1button)
        resetScore(button: p2button)
        p1button.backgroundColor = p1startColor
        p2button.backgroundColor = p2startColor
        
        countdown()
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "SETTINGS", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        ac.presentSettings(string: maxDefaults, settings: ac, vc: self)
    }
    
    func enableMenu() {
        resetButton.isHidden = false
        resetButton.isEnabled = true
        settingsButton.isHidden = false
        settingsButton.isEnabled = true
    }
    
    func disableMenu() {
        resetButton.isHidden = true
        resetButton.isEnabled = false
        settingsButton.isHidden = true
        settingsButton.isEnabled = false
    }

    func disableTaps() {
        p2button.isEnabled = false
        p1button.isEnabled = false
    }
    
    func gameFinish() {
        enableMenu()
        disableTaps()
    }
    
    func resetScore(button: UIButton) {
        button.setTitle(String(0), for: .normal)
        button.setTitle(String(0), for: .disabled)
    }
    
    func darkenColor(button: UIButton) {
        button.backgroundColor = button.backgroundColor!.darker(by: CGFloat(30/GameState.maxScore))
    }
    
    func countdown() {
        SwiftSpinner.show("3")
        SwiftSpinner.show(delay: 1.0, title: "2")
        SwiftSpinner.show(delay: 2.0, title: "1")
        SwiftSpinner.show(delay: 3, title: "GO")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
            SwiftSpinner.hide()
            self.p1button.isEnabled = true
            self.p2button.isEnabled = true
        }
    }
    
}


