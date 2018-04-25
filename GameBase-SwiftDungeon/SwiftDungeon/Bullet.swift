//
//  Bullet.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 4/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : Entity {
    
    var velocity: CGPoint = CGPoint(x: 0, y: 0)
    var damage: CGFloat = 10
    var lifetime: CGFloat = 5
    
    init(_ image: String) {
        super.init(imageName: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        lifetime = lifetime - CGFloat(deltaTime)
        
        position = CGPoint(x: position.x + (velocity.x * CGFloat(deltaTime)), y: position.y + (velocity.y * CGFloat(deltaTime)))
    }
    
}
