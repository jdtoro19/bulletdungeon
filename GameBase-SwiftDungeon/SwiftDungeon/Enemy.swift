//
//  Enemy.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Entity, ShootProtocol {    
    //Speed of Enemy
    var velocity: CGFloat = 200
    //Heath
    var health: CGFloat = 1000
    //SHoot timer
    var shootTimer: CGFloat = 0
    var shootTimerTime: CGFloat = 2
    //Damage
    var damage: CGFloat = 1
    //Bullets
    var bullets:[Bullet] = []
    //Score Value
    var score: CGFloat = 500
    
    init(_ image: String) {
        super.init(imageName: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        shootTimer -= CGFloat(deltaTime)
        
        // Move down
        position = CGPoint(x: position.x, y: position.y - (velocity * CGFloat(deltaTime)))
        
        // Update bullets and delete them after their lifetime is below 0
        for (index, bullet) in bullets.enumerated().reversed() {
            bullet.update(currentTime)
            
            if(bullet.lifetime < 0) {
                bullet.removeFromParent()
                bullets.remove(at: index)
            }
        }
        
        // Check below screen, delete if true
        if(position.y < -200) {
            die()
        }
    }
    
    // attack
    func shoot() -> Bullet
    {
        let bullet = EnemyBullet()
        bullet.position = position
        return bullet
    }
    
    // Death
    func die() {
        removeAllChildren()
        removeFromParent()
        for (index, bullet) in bullets.enumerated().reversed() {
            bullet.removeFromParent()
            bullets.remove(at: index)
        }
    }
}

