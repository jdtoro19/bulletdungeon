//
//  EnemyFactory.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/20/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation

class EnemyFactory {
    
    enum EnemyType {
        case normal, fast, slow
    }
    
    func createRandomEnemy() -> Enemy {
        let randomIndex = Int(arc4random_uniform(10))
        
        if(randomIndex >= 4) {
            return createEnemy(.normal)
        }
        else if(randomIndex <= 3 && randomIndex >= 2) {
            return createEnemy(.fast)
        }
        else if(randomIndex == 1) {
            return createEnemy(.slow)
        }
        else {
             return createEnemy(.normal)
        }
    }
    
    func createEnemy(_ type: EnemyType) -> Enemy {
        if(type == .normal) {
            return NormalEnemy()
        }
        else if (type == .fast) {
            return FastEnemy()
        }
        else if (type == .slow) {
            return SlowEnemy()
        }
        else {
            return NormalEnemy()
        }
    }    
}
