//
//  Gamestate.swift
//  day1
//
//  Created by Brian Xu on 3/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

class GameState {

    static var maxScore = 20
    static var firstGame = true

    static func newMax(n: Int) {
        maxScore = n
    }
    static func firstGameStart() {
        firstGame = false
    }
}
