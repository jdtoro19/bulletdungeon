//
//  GameScene.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 2/28/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameManager: GameManager?
    
    var stickActive:Bool = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = #colorLiteral(red: 0.1631777585, green: 0.1484030187, blue: 0.2081771195, alpha: 1)
        gameManager = GameManager()
        gameManager?.scene = self
        gameManager?.startGame(size: size)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        gameManager?.update(currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager?.player.isAttacking = true
        if(gameManager?.player.isDead)! {
            gameManager?.reloadLevel()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            gameManager?.player.moveTo(touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       gameManager?.player.isAttacking = false
    }
    
}
