    //
//  GameManager.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import GameKit

class GameManager {
    
    // Map
    private let map = Map(imageNamed: "map")
    
    // Entities
    let player = Player()
    var enemies:[Enemy] = []
    private var maxEnemies = 3
    private let enemyFactory = EnemyFactory()
    var enemySpawnTimer: CGFloat = 0
    var enemySpawnTime: CGFloat = 2
    
    // Scene
    weak var scene: GameScene?
    
    // UI
    var scoreLabel: SKLabelNode!
    var healthLabel: SKLabelNode!
    var gameoverLabel: SKLabelNode!
    
    func startGame(size: CGSize) {
        // Make Map
        map.zPosition = -1
        map.position = CGPoint(x: size.width / 2, y: size.height / 2 + 120)
        map.setScale(2.5)
        
        // Make Player
        player.zPosition = 1
        player.position = map.playerSpawn
        player.health = player.maxHealth
        player.setScale(5)        
        
        // UI
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 250, y: 50)
        scoreLabel.setScale(2)
        
        healthLabel = SKLabelNode(fontNamed: "Chalkduster")
        healthLabel.text = "Health: 0"
        healthLabel.horizontalAlignmentMode = .left
        healthLabel.position = CGPoint(x: 950, y: 50)
        healthLabel.setScale(2)
        
        healthLabel = SKLabelNode(fontNamed: "Chalkduster")
        healthLabel.text = "Health: 0"
        healthLabel.horizontalAlignmentMode = .left
        healthLabel.position = CGPoint(x: 950, y: 50)
        healthLabel.setScale(2)
        
        gameoverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameoverLabel.text = "You Died | Tap to Restart"
        gameoverLabel.horizontalAlignmentMode = .center
        gameoverLabel.position = CGPoint(x: 750, y: 1200)
        gameoverLabel.setScale(2)
        gameoverLabel.isHidden = true
        
        // Add children to scene
        populateLevel()
        
        // Populate level with enemies
        populateEnemies()
    }
    
    func update(_ currentTime: TimeInterval) {
        
        // Update Player
        player.update(currentTime)
        
        scoreLabel.text = "Score: \(Int(player.score))"
        healthLabel.text = "Health: \(player.health)"
        
        // Update Enemies and check for collisions
        var enemiesToBeDeleted: [Int] = []
        
        for enemy in (enemies) {
            enemy.update(currentTime)
            
            // Check player collision
            let playerCollision = enemy.collision(items: [player]).first
            if let _ = playerCollision  {
                player.takeDamage()
                enemy.die()
                enemiesToBeDeleted.append(enemies.index(of: enemy)!)
            }
            
            // Check bullet colision
            let bulletCollision = enemy.collision(items: player.bullets).first
            if let _ = bulletCollision  {
                enemy.health -= player.damage
                if(enemy.health < 0) {
                    enemy.die()
                    enemiesToBeDeleted.append(enemies.index(of: enemy)!)
                    player.score += enemy.score
                }
            }
            
            // Check enemy bullets with player
            let playerBulletCollision = player.collision(items: enemy.bullets).first
            if let _ = playerBulletCollision  {
                player.takeDamage()
            }
        }
        
        // Every frame if there are enemies to be deleted, they will go into this array
        deleteEnemies(enemiesToBeDeleted)
        
        // Spawn enemies when the timer reaches 0
        enemySpawnTimer = enemySpawnTimer - CGFloat(player.deltaTime)
        if(enemySpawnTimer < 0) {
            populateEnemies()
            enemySpawnTimer = enemySpawnTime
        }
        
        if(player.isDead) {
            gameoverLabel.isHidden = false
        }
        else {
            gameoverLabel.isHidden = true
        }
        
        if(player.score < 25000) {
            enemySpawnTime = 2
            maxEnemies = 3
            player.currentGun = Player.GunType.light
        }
        else if(player.score < 50000) {
            enemySpawnTime = 1.5
            maxEnemies = 5
            player.currentGun = Player.GunType.medium
        }
        else if(player.score < 75000) {
            enemySpawnTime = 1
            maxEnemies = 7
            player.currentGun = Player.GunType.heavy
        }
        else if(player.score < 100000) {
            enemySpawnTime = 0.2
            maxEnemies = 15
            player.damage = player.damage * 2
        }
     
    }
    
    func reloadLevel() {
        // Fade out
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scene?.view?.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
            
            // Fade in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.scene?.view?.alpha = 1.0
                
                // Set properties and add children when screen is faded
                self.resetLevel()
                self.populateLevel()
                self.populateEnemies()
                
            }, completion: nil)
        })
    }
    
    private func resetLevel() {
        scene?.removeAllChildren()
        enemies.removeAll()
        player.position = self.map.playerSpawn
        player.resetPlayer()
    }
    
    private func populateLevel() {
        //scene?.addChild(map)
        scene?.addChild(player)
        scene?.addChild(scoreLabel)
        scene?.addChild(healthLabel)
        scene?.addChild(gameoverLabel)
    }
    
    private func populateEnemies() {
        for _ in 0..<maxEnemies {
            let randomIndex = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
            let eTemp = enemyFactory.createRandomEnemy()
            eTemp.position = map.enemySpawns[randomIndex]
            eTemp.setScale(5)
            scene?.addChild(eTemp)
            enemies.append(eTemp)
        }
    }
    
    //Helper function to properly remove the enemies from the array
    private func deleteEnemies(_ enemyIndex: [Int]) {
        let reversedIndex = enemyIndex.reversed()
        
        for index in reversedIndex {
            enemies.remove(at: index)
        }
    }
    
}

