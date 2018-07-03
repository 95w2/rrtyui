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
    var maxScore = 20
    
    var p1startColor: UIColor!
    var p2startColor: UIColor!
    
    var maxDefaults = "previousMax"
    var firstGameStart = true
    
    lazy var player: AVAudioPlayer = {
        return AVAudioPlayer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.object(forKey: maxDefaults) != nil {
            maxScore = UserDefaults.standard.integer(forKey: maxDefaults)
        }
        
        p1startColor = p1button.backgroundColor!
        p2startColor = p2button.backgroundColor!
        
        p2scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func p1buttonTapped(_ sender: UIButton) {
        p1score += 1
        p1button.setTitle(String(p1score), for: .normal)
        sender.backgroundColor = p1button.backgroundColor!.darker(by: CGFloat(30/maxScore))
        player.play()
        
        if p1score == maxScore {
            p1button.setTitle("WINNER", for: .disabled)
            gameFinish()
        }
    }
    
    @IBAction func p2buttonTapped(_ sender: UIButton) {
        p2score += 1
        p2button.setTitle(String(p2score), for: .normal)
        sender.backgroundColor = p2button.backgroundColor!.darker(by: CGFloat(30/maxScore))
        player.play()
        
        if p2score == maxScore {
            p2button.setTitle("WINNER", for: .disabled)
            gameFinish()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        if firstGameStart == true {
            guard let soundPath = Bundle.main.path(forResource: "tap", ofType: "wav") else {
                return
            }
            let soundURL = NSURL(fileURLWithPath: soundPath) as URL
            player = try! AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.wav.rawValue)
            
            resetButton.setTitle("RESET", for: .normal)
            firstGameStart = false
            
        }
        
        resetButton.isHidden = true
        resetButton.isEnabled = false
        settingsButton.isHidden = true
        settingsButton.isEnabled = false
        
        p1score = 0
        p1button.setTitle(String(p1score), for: .normal)
        p1button.setTitle(String(p1score), for: .disabled)
        p1button.backgroundColor = p1startColor
        
        p2score = 0
        p2button.setTitle(String(p2score), for: .normal)
        p2button.setTitle(String(p2score), for: .disabled)
        p2button.backgroundColor = p2startColor
        
        SwiftSpinner.show("3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SwiftSpinner.show("2")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            SwiftSpinner.show("1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SwiftSpinner.show("GO")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            SwiftSpinner.hide()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.p1button.isEnabled = true
            self.p2button.isEnabled = true
        }
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        createSettings()
    }
    
    func enableMenu() {
        resetButton.isHidden = false
        resetButton.isEnabled = true
        settingsButton.isHidden = false
        settingsButton.isEnabled = true
    }

    func disableTaps() {
        p2button.isEnabled = false
        p1button.isEnabled = false
    }
    
    func gameFinish() {
        enableMenu()
        disableTaps()
    }
    
    func createSettings() {
        let settings = UIAlertController(title: "SETTINGS", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        settings.addAction(UIAlertAction(title: "CHANGE GAME MODE", style: .default, handler: { (alert: UIAlertAction!) in self.createGamemodes() }))
        settings.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        self.present(settings, animated: true, completion: nil)
    }
    
    func createGamemodes() {
        let gamemodes = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 20", style: .default, handler: { (alert: UIAlertAction!) in self.maxScore = 20
            UserDefaults.standard.set(self.maxScore, forKey: self.maxDefaults)
        }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 30", style: .default, handler: { (alert: UIAlertAction!) in self.maxScore = 30
            UserDefaults.standard.set(self.maxScore, forKey: self.maxDefaults)
        }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 50", style: .default, handler: { (alert: UIAlertAction!) in self.maxScore = 50
            UserDefaults.standard.set(self.maxScore, forKey: self.maxDefaults)
        }))
        gamemodes.addAction(UIAlertAction(title: "CUSTOM", style: .default, handler: { (alert: UIAlertAction!) in self.createCustomMax() }))
        gamemodes.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        self.present(gamemodes, animated: true, completion: nil)
    }
    
    func createCustomMax() {
        let customMax = UIAlertController(title: "SET MAX SCORE", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        customMax.addTextField(configurationHandler: { (textField) in
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
        })
        customMax.addAction(UIAlertAction(title: "CONFIRM", style: .default, handler: {(alert: UIAlertAction!) in
            let textField = customMax.textFields![0]
            if let text = textField.text, !text.isEmpty
            {
                let newMax: Int? = Int(textField.text!)
                self.maxScore = newMax!
                UserDefaults.standard.set(self.maxScore, forKey: self.maxDefaults)
            }
        }))
        customMax.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        self.present(customMax, animated: true, completion: nil)
    }
}


