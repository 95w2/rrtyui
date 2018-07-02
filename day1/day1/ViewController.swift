//
//  ViewController.swift
//  day1
//
//  Created by Brian Xu on 2/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var p1button: UIButton!
    @IBOutlet weak var p2button: UIButton!
    @IBOutlet weak var p2scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var p1score = 0
    var p2score = 0
    var maxScore = 20
    
    var p1color: UIColor!
    var p2color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        p1color = p1button.backgroundColor!
        p2color = p2button.backgroundColor!
        
        p2scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        resetButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func p1buttonTapped(_ sender: UIButton) {
        p1score += 1
        if p1score == 20 {
            p1button.setTitle("WINNER", for: .disabled)
            
            p1button.isEnabled = false
            p2button.isEnabled = false
            resetButton.isHidden = false
            resetButton.isEnabled = true
        }
        p1button.setTitle(String(p1score), for: .normal)
        
        sender.backgroundColor = p1button.backgroundColor!.darker(by: 1.5)
    }
    
    @IBAction func p2buttonTapped(_ sender: UIButton) {
        p2score += 1
        p2button.setTitle(String(p2score), for:.normal)
        if p2score == 20 {
            p2button.setTitle("WINNER", for: .disabled)
            
            p2button.isEnabled = false
            p1button.isEnabled = false
            resetButton.isHidden = false
            resetButton.isEnabled = true
        }
        
        sender.backgroundColor = p2button.backgroundColor!.darker(by: 1.5)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetButton.isHidden =	 true
        resetButton.isEnabled = false
        
        p1score = 0
        p1button.isEnabled = true
        p1button.setTitle(String(p1score), for:.normal)
        p1button.backgroundColor = p1color
        
        p2score = 0
        p2button.isEnabled = true
        p2button.setTitle(String(p2score), for:.normal)
        p2button.backgroundColor = p2color
    }
    
}

