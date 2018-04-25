//
//  SlowEnemy.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/24/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class SlowEnemy: Enemy {
    
    init() {
        super.init("slime_walk_03")
        velocity = 200
        shootTimerTime = 0.5
        health = 2000
        score = 600
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        // Shoot bullets when the timer reaches 0
        if(shootTimer < 0) {
            var bTemp = shoot()
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            bTemp = shoot()
            bTemp.position.x = position.x + 20
            bTemp.position.y = position.y + 20
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            bTemp = shoot()
            bTemp.position.x = position.x - 20
            bTemp.position.y = position.y + 20
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            shootTimer = shootTimerTime
        }
    }
    
}
