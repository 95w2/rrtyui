//
//  Gamestate.swift
//  day1
//
//  Created by Brian Xu on 3/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class GameState {

     var maxScore = 20
     var firstGame = true

     func newMax(n: Int) {
        maxScore = n
    }
    
    func firstGameStart() {
        firstGame = false
    }
    
    func finish(p1: UIButton, p2: UIButton, rs: UIButton, st: UIButton) {
        enableMenu(rs: rs, st: st)
        disableTaps(p1: p1, p2: p2)
    }
    
    func disableTaps(p1: UIButton, p2: UIButton) {
        p1.isEnabled = false
        p2.isEnabled = false
    }
    
    func enableMenu(rs: UIButton, st: UIButton) {
        rs.isHidden = false
        rs.isEnabled = true
        st.isHidden = false
        st.isEnabled = true
    }
    
    func disableMenu(rs: UIButton, st: UIButton) {
        rs.isHidden = true
        rs.isEnabled = false
        st.isHidden = true
        st.isEnabled = false
    }
    
}
