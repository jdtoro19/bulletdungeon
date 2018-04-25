//
//  Map.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Map : SKSpriteNode {
    
    // This is a base class that can be used
    // to make maps with different images and spawn points
    // but for now we will just use this class
    
    var playerSpawn = CGPoint(x: 768, y: 200)
    
    var enemySpawns:[CGPoint] = [CGPoint(x: 300, y: 2900), CGPoint(x: 400, y: 2800), CGPoint(x: 500, y: 2700), CGPoint(x: 600, y: 2600), CGPoint(x: 700, y: 2600), CGPoint(x: 800, y: 2600), CGPoint(x: 900, y: 2600), CGPoint(x: 1000, y: 2600), CGPoint(x: 1100, y: 2600), CGPoint(x: 1200, y: 2600), CGPoint(x: 1300, y: 2600)]
    
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
