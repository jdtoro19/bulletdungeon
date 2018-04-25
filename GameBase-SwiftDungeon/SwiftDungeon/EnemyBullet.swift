//
//  EnemyBullet.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBullet : Bullet {
    
    init() {
        super.init("slime_walk_02")
        velocity = CGPoint(x: 0, y: -500)
        setScale(2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
