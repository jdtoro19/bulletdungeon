//
//  Player.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Player : Entity, ShootProtocol {
    
    //Animation
    private var textureAnimation: [SKTexture] = []
    //Check if already animating (Prevent spamming)
    var isAnimating:Bool = false
    //Check if attacking
    var isAttacking:Bool = false
    //Check if dead
    var isDead:Bool = false
    //SKAction for animation
    var animationAction:SKAction = SKAction()
    //Timer for animation
    var animTimer:Double = 0
    //Health
    var health:Int = 0
    var maxHealth:Int = 20
    //Damage
    var damage: CGFloat = 100
    //Hit stun timer
    var stunTimer: CGFloat = 0
    var stunTimerTime: CGFloat = 0.5;
    //Bullets
    var bullets:[Bullet] = []
    //Fire rate
    var firerate: CGFloat = 0.1
    var firerateTimer: CGFloat = 0
    //Score
    var score: CGFloat = 0
    
    //screen bounds struct
    struct ScreenBounds {
        var top: CGFloat = 1848
        var bottom: CGFloat = 0
        var left: CGFloat = 0
        var right: CGFloat = 1536
    }
    
    var screen = ScreenBounds()
    
    // Gun type enum
    enum GunType {
        case light, medium, heavy
    }
    
    var currentGun: GunType = .light
    
    init() {
        super.init(imageName: "ship_1")
        idle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        // If dead exit early
        if (isDead) {
            return
        }
     
        stunTimer -= CGFloat(deltaTime)
        if(stunTimer < 0) {
            stunTimer = 0
        }
        
        // Keep player within level bounds
        if(position.y < screen.bottom)
        {
            position.y = screen.bottom
        }
        if(position.x < screen.left)
        {
            position.x = screen.left
        }
        if(position.y > screen.top)
        {
            position.y = screen.top
        }
        if(position.x > screen.right)
        {
            position.x = screen.right
        }
        
        firerateTimer -= CGFloat(deltaTime)
        if(firerateTimer < 0) {
            firerateTimer = 0
        }
        
        // If the player is in the attacking state then shoot bullets
        if(isAttacking && firerateTimer == 0) {
            
            // check the current gun type
            if(currentGun == .light) {
                shootLight()
            }
            else if(currentGun == .medium) {
                shootMedium()
            }
            else if(currentGun == .heavy) {
                shootHeavy()
            }
            
            firerateTimer = firerate
        }
        
        // Update bullets and delete them after their lifetime is below 0
        for (index, bullet) in bullets.enumerated().reversed() {
            bullet.update(currentTime)
            
            if(bullet.lifetime < 0) {
                bullet.removeFromParent()
                bullets.remove(at: index)
            }
        }
    }
    
    //Idle animation
    func idle() {
        textureAnimation = [SKTexture(imageNamed: "ship_1"),
                            SKTexture(imageNamed: "ship_2"),
                            SKTexture(imageNamed: "ship_3"),
                            SKTexture(imageNamed: "ship_4"),
                            SKTexture(imageNamed: "ship_5")]
        
        animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.2)
        let repeatAction = SKAction.repeatForever(animationAction)
        self.run(repeatAction)
    }
    
    //Move animation/action
    func moveTo(_ newPosition: CGPoint) {
        if(!isDead) {
            position.x = newPosition.x
        }
    }
    
    // attack, returns a bullet
    func shoot() -> Bullet
    {
        let bullet = NormalBullet()
        bullet.position = position
        return bullet
    }
    
    //Death animation
    func death() {
        isDead = true
        textureAnimation = [SKTexture(imageNamed: "death_1"),
                            SKTexture(imageNamed: "death_2"),
                            SKTexture(imageNamed: "death_3"),
                            SKTexture(imageNamed: "death_4"),
                            SKTexture(imageNamed: "death_5"),
                            SKTexture(imageNamed: "death_6")]
        
        animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.08)
        self.removeAllActions()
        self.run(animationAction)
        
        for (index, bullet) in bullets.enumerated().reversed() {
            bullet.removeFromParent()
            bullets.remove(at: index)
        }
    }
    
    func takeDamage() {
        if(stunTimer <= 0) {
            stunTimer = stunTimerTime
            health -= 1
            if (health == 0) {
                health = 0
                death()
            }
        }
    }
    
    func resetPlayer() {
        health = maxHealth
        isDead = false
        score = 0
        damage = 100
        idle()
    }
    
    // Different functions for the diferent gun types
    func shootLight() {
        var bTemp = shoot()
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
    }
    
    func shootMedium() {
        var bTemp = shoot()
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
    }
    
    func shootHeavy() {
        var bTemp = shoot()
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bTemp.velocity.x = CGFloat(250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 20
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 20
        bTemp.velocity.x = CGFloat(-250)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 60
        bTemp.velocity.x = CGFloat(-100)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 80
        bTemp.velocity.x = CGFloat(0)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 100
        bTemp.velocity.x = CGFloat(-800)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 60
        bTemp.velocity.x = CGFloat(100)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 80
        bTemp.velocity.x = CGFloat(0)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 100
        bTemp.velocity.x = CGFloat(800)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 60
        bTemp.velocity.x = CGFloat(-100)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 80
        bTemp.velocity.x = CGFloat(0)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x + 100
        bTemp.velocity.x = CGFloat(-800)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 60
        bTemp.velocity.x = CGFloat(100)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 80
        bTemp.velocity.x = CGFloat(0)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
        
        bTemp = shoot()
        bTemp.position.x = position.x - 100
        bTemp.velocity.x = CGFloat(800)
        bullets.append(bTemp)
        scene?.addChild(bTemp)
    }
}

