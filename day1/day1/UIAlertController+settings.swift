//
//  UIAlertController+settings.swift
//  day1
//
//  Created by Brian Xu on 3/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

extension UIAlertController {
    func presentSettings(string: String, settings: UIAlertController, vc: UIViewController) {
        settings.addAction(UIAlertAction(title: "CHANGE GAME MODE", style: .default, handler: { (alert: UIAlertAction!) in self.presentGamemodes(s: string, vc: vc) }))
        settings.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        vc.present(settings, animated: true, completion: nil)
    }
    
    func presentGamemodes(s: String, vc: UIViewController) {
        let gamemodes = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 20", style: .default, handler: { (alert: UIAlertAction!) in
            GameState.maxScore = 20
            UserDefaults.standard.set(GameState.maxScore, forKey: s)
        }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 30", style: .default, handler: { (alert: UIAlertAction!) in
            GameState.maxScore = 30
            UserDefaults.standard.set(GameState.maxScore, forKey: s)
        }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 50", style: .default, handler: { (alert: UIAlertAction!) in GameState.maxScore = 50
            UserDefaults.standard.set(GameState.maxScore, forKey: s)
        }))
        gamemodes.addAction(UIAlertAction(title: "CUSTOM", style: .default, handler: { (alert: UIAlertAction!) in self.presentCustomMax(s: s, vc: vc) }))
        gamemodes.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        vc.present(gamemodes, animated: true, completion: nil)
    }
    
    func presentCustomMax(s: String, vc: UIViewController) {
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
                GameState.maxScore = newMax!
                UserDefaults.standard.set(GameState.maxScore, forKey: s)
            }
        }))
        customMax.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        vc.present(customMax, animated: true, completion: nil)
    }
}
