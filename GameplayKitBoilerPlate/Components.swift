//
//  Components.swift
//  GameplayKitBoilerPlate
//
//  Created by Parker Cooper on 11/19/20.
//

import GameplayKit

class PlayerControl: GKComponent {
    var geometryComponent: GeometryComponent? {
        return entity?.component(ofType: GeometryComponent.self)
    }
    
    func colorGreen() {
        geometryComponent?.changeGeoColor(to: .green)
    }
    
    func changePosition(to point: CGPoint) {
        geometryComponent?.changePosition(to: point)
    }

}

class FollowComponent: GKComponent {
    // simple rotate to players position
    var geometryComponent: GeometryComponent? {
        return entity?.component(ofType: GeometryComponent.self)
    }
    
    func followNode(playerNode: SKSpriteNode) {
        let currentPosition = geometryComponent!.geometryNode.position
        
        let angle = atan2(currentPosition.y - playerNode.position.y, currentPosition.x - playerNode.position.x)
        
        let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(Double.pi * 0.5), duration: 0.0)
        
        geometryComponent!.runAction(action: SKAction.sequence([rotateAction]))
    }
    
}

class GeometryComponent: GKComponent {
    // Any entity with a size
    let geometryNode: SKSpriteNode
    
    init(geometryNode: SKSpriteNode) {
        self.geometryNode = geometryNode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeGeoColor(to color: SKColor) {
        geometryNode.color = color
    }
    
    func changePosition(to point: CGPoint) {
        self.geometryNode.position = point
    }
    
    func runAction(action: SKAction) {
        self.geometryNode.run(action)
    }
}
