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

class GameViewController: UIViewController {
    
    let gameState = GameState()
    
    @IBOutlet weak var p1button: UIButton!
    @IBOutlet weak var p2button: UIButton!
    @IBOutlet weak var p2scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var p1startColor: UIColor!
    var p2startColor: UIColor!
    
    static let maxDefaults = "previousMax"
    lazy var player: AVAudioPlayer = {
        return AVAudioPlayer()
    }()
    
    var p1score = 0 {
        didSet {
            p1button.setTitle(String(p1score), for: .normal)
            p1button.backgroundColor = p1startColor!.darker(by: CGFloat(40/gameState.maxScore*p1score))
            if p1score == gameState.maxScore {
                p1button.setTitle("WINNER", for: .disabled)
                gameState.finish(p1: p1button, p2: p2button, rs: resetButton, st: settingsButton)
            }
        }
    }
    var p2score = 0 {
        didSet {
            p2button.setTitle(String(p2score), for: .normal)
            p2button.backgroundColor = p2startColor!.darker(by: CGFloat(40/gameState.maxScore*p2score))
            if p2score == gameState.maxScore {
                p2button.setTitle("WINNER", for: .disabled)
                gameState.finish(p1: p1button, p2: p2button, rs: resetButton, st: settingsButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 50.0))
        if UserDefaults.standard.object(forKey: GameViewController.maxDefaults) != nil {
            gameState.maxScore = UserDefaults.standard.integer(forKey: GameViewController.maxDefaults)
        }
        p1startColor = p1button.backgroundColor!
        p2startColor = p2button.backgroundColor!
        
        p2scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func p1buttonTapped(_ sender: UIButton) {
        p1score += 1
        player.play()
    }
    
    @IBAction func p2buttonTapped(_ sender: UIButton) {
        p2score += 1
        player.play()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        if gameState.firstGame {
            guard let soundPath = Bundle.main.path(forResource: "tap", ofType: "wav") else {
                return
            }
            let soundURL = NSURL(fileURLWithPath: soundPath) as URL
            player = try! AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.wav.rawValue)
            
            resetButton.setTitle("RESET", for: .normal)
            gameState.firstGameStart()
        }
        player.prepareToPlay()
        gameState.disableMenu(rs: resetButton, st: settingsButton)
        
        p1score = 0
        p2score = 0
        
        countdown()
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "SETTINGS", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        ac.presentSettings(string: GameViewController.maxDefaults, settings: ac, vc: self, gameState: gameState)
    }
        
    func countdown() {
        SwiftSpinner.show("3")
        SwiftSpinner.show(delay: 1.0, title: "2")
        SwiftSpinner.show(delay: 2.0, title: "1")
        SwiftSpinner.show(delay: 3.0, title: "GO")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
            SwiftSpinner.hide()
            self.p1button.isEnabled = true
            self.p2button.isEnabled = true
        }
    }
    
}


