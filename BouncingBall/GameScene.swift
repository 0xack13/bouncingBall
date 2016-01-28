//
//  GameScene.swift
//  BouncingBall
//
//  Created by Saleh Albatati on 1/26/16.
//  Copyright (c) 2016 Saleh Albatati. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var isTouchingPaddle = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)*/
        
        let border = SKPhysicsBody(edgeLoopFromRect: self.frame)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        let ball = childNodeWithName("bouncingBall") as! SKSpriteNode
        
        ball.physicsBody!.applyImpulse(CGVectorMake(30, -30))
        ball.physicsBody!.allowsRotation = false
        ball.physicsBody!.friction = 0
        ball.physicsBody!.linearDamping = 0
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.angularDamping = 0
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        /*
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }*/
        
        let touch = touches.first as UITouch!
        let location = touch.locationInNode((self))
        
        if let body = self.physicsWorld.bodyAtPoint(location) {
            if body.node!.name == "paddle" {
            isTouchingPaddle = true
            }
        }
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isTouchingPaddle {
            let touch = touches.first as UITouch!
            let location = touch.locationInNode((self))
            let prevLocation = touch.previousLocationInNode(self)
            
            let paddle = childNodeWithName("paddle") as! SKSpriteNode
            
            let xPos = paddle.position.x + (location.x - prevLocation.x)
            
            paddle.position = CGPointMake(xPos, paddle.position.y)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouchingPaddle = false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
