//
//  GameScene.swift
//  GameplayKitBoilerPlate
//
//  Created by Parker Cooper on 11/19/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
     
    }
    
    var playerNode: Player!
    var enemyNode: Player!
    
    var playerControlComponentSystem = GKComponentSystem(componentClass: PlayerControl.self)
    var followComponentSystem = GKComponentSystem(componentClass: FollowComponent.self)
    var agentComponentSystem = GKComponentSystem(componentClass: GKAgent2D.self)

    override func didMove(to view: SKView) {
        playerNode = Player(size: CGSize(width: 50, height: 50), color: .blue, behavior: nil, playerControl: true, follow: false, texture: nil)
        enemyNode = Player(size: CGSize(width: 50, height: 50), color: .red, behavior: nil, playerControl: false, follow: true, texture: nil)

        let playerEntity = playerNode.makeEntity(playerNode, playerControl: true, follow: false)
        playerNode.entity = playerEntity
        
        let enemyEntity = enemyNode.makeEntity(enemyNode, playerControl: false, follow: true)
        enemyNode.entity = enemyEntity
        
        entities.append(playerEntity)
        entities.append(enemyEntity)
        
        for entity in entities {
            playerControlComponentSystem.addComponent(foundIn: entity)
            followComponentSystem.addComponent(foundIn: entity)
            agentComponentSystem.addComponent(foundIn: entity)
        }
        
        addChild(playerNode)
        addChild(enemyNode)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            for case let component as PlayerControl in playerControlComponentSystem.components {
                component.changePosition(to: location)
                component.colorGreen()
            }
        }
    }
    
    
   
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
        
        // turn enemy according to player position
        for case let component as FollowComponent in followComponentSystem.components {
            component.followNode(playerNode: playerNode)
        }
    }
}
