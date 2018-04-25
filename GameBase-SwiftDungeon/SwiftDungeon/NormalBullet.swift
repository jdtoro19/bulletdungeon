//
//  NormalBullet.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class NormalBullet : Bullet {
    
    init() {
        super.init("slime_walk_01")
        velocity = CGPoint(x: 0, y: 3000)
        lifetime = 0.7
        setScale(2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
