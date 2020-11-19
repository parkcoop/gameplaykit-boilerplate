//
//  Player.swift
//  GameplayKitBoilerPlate
//
//  Created by Parker Cooper on 11/19/20.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: SKSpriteNode, GKAgentDelegate {
    
    var agent = GKAgent()
    
    init(size: CGSize, color: UIColor, behavior: GKBehavior?, playerControl: Bool, follow: Bool,
         texture: SKTexture?) {
        if let texture = texture {
            super.init(texture: texture, color: color, size: texture.size())
        } else {
            super.init(texture: texture, color: color, size: size)
        }
        
        agent = makeAgentFromNode(self, behavior: behavior)
    }
    
    
    // Make agent for a node
    
    func makeAgentFromNode(_ node: SKSpriteNode, behavior: GKBehavior?) -> GKAgent {
        let agent = GKAgent2D()
        agent.radius = Float(node.size.width / 2)
        agent.position = vector2(Float(node.position.x), Float(node.position.y))
        agent.delegate = self
        agent.maxSpeed = 200
        agent.maxAcceleration = 200
        return agent
    }
    
    func makeEntity(_ node: SKSpriteNode?, playerControl: Bool, follow: Bool) -> GKEntity {
        let entity = GKEntity()
        
        if let node = node {
            let geoComponent = GeometryComponent(geometryNode: node)
            // Add to entity
            entity.addComponent(geoComponent)
        }
        
        if playerControl {
            let playerControlComponent = PlayerControl()
            entity.addComponent(playerControlComponent)
        }
        
        if follow {
            let followComponent = FollowComponent()
            entity.addComponent(followComponent)
        }
        
        return entity
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
