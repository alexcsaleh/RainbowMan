//
//  GameScene.swift
//  Testing the action
//
//  Created by Alexander Saleh on 2/20/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//

import SpriteKit
import UIKit


class GameScene: SKScene {
    
    let addedFloor = SKSpriteNode(imageNamed: "mainMenuFloor")//Moet nog verranderd worden
    let playbutton = SKSpriteNode(imageNamed: "startButtonNotPressed")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
      
        addBG()
        self.playbutton.position = CGPointMake(CGRectGetMidX(self.frame), -25)
        self.addChild(self.playbutton)
        
        self.addedFloor.anchorPoint = CGPointMake(0, 0.5)
        self.addedFloor.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + (self.addedFloor.size.height / 2))
        
        
        //addFloor()
        
        
        
        
    }
    func addBG() {
        var background = SKSpriteNode(imageNamed: "background")
        background.size.width = self.frame.size.width
        background.size.height = self.frame.size.height
        //background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        addChild(background)
        
        self.addChild(self.addedFloor) // add de vloer toe aan de background
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            for touch: AnyObject in touches {
            }
                let location = touch.locationInNode(self)
                if self.nodeAtPoint(location) == self.playbutton {
                    var scene = InGameScene(size: self.size)
                    let skView = self.view as SKView!
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .ResizeFill
                    scene.size = skView.bounds.size
                    scene.anchorPoint = CGPointMake(CGRectGetMidX(GameScene().frame), CGRectGetMidY(GameScene().frame))
                    skView.presentScene(scene)
                    
                }
            }
      
        }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
