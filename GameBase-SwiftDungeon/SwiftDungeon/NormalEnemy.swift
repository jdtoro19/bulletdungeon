//
//  NormalEnemy.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/24/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class NormalEnemy : Enemy {
    
    init() {
        super.init("slime_walk_05")
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
            bTemp.velocity.x = CGFloat(-250)
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            bTemp = shoot()
            bTemp.velocity.x = CGFloat(250)
            bullets.append(bTemp)
            scene?.addChild(bTemp)
            
            shootTimer = shootTimerTime
        }
    }
}
