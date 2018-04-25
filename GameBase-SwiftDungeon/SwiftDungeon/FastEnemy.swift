//
//  FastEnemy.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/24/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class FastEnemy: Enemy {
    
    init() {
        super.init("slime_walk_04")
        velocity = 700
        shootTimerTime = 0.5
        health = 500
        score = 400
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        // Shoot bullets when the timer reaches 0
        if(shootTimer < 0) {
            var bTemp = shoot()
            bTemp.velocity.y = -500
            bTemp.velocity.x = 500
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            bTemp = shoot()
            bTemp.velocity.y = -500
            bTemp.velocity.x = -500
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            shootTimer = shootTimerTime
        }
    }
    
}
