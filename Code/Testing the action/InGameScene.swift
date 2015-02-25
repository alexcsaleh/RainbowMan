//
//  InGameScene.swift
//  Testing the action
//
//  Created by Alexander Saleh on 2/20/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//

import SPriteKit
import UIKit
import Foundation




class InGameScene: SKScene {
    
    let spawningBar = SKSpriteNode(imageNamed: "infiniteScrollingGround")
    let heroStatic = SKSpriteNode(imageNamed: "HeroStatic")
    let block = SKSpriteNode(imageNamed: "block")
    let blockDouble = SKSpriteNode(imageNamed: "blockDouble")
    var scoreText = SKLabelNode(fontNamed: "Chalkduster")
    var origRunningFloorPositionXPoint = CGFloat(0)
    var maxBarX: CGFloat = CGFloat(0)
    var floorSpeed = 1.5 // moving floor speed
    var heroBaseline = CGFloat(0)
    var onGround = true
    var velocityY = CGFloat(0)
    let gravity = CGFloat(0.15) // In-game gravity
    var blockMaxX = CGFloat(0)
    var origRunningBlockPositionXPoint = CGFloat (0)
    
    var score = 0
    
    
    override func didMoveToView(view: SKView) {
        println("We are at the new scene!")
        addBG() // adding the background
        self.spawningBar.anchorPoint = CGPointMake(0.15, 0.5)
        self.spawningBar.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + (self.spawningBar.size.height / 2))
        self.origRunningFloorPositionXPoint = self.spawningBar.position.x
        self.maxBarX = self.spawningBar.size.width - self.frame.size.width// geeft de total width van de spawningBar aan
        self.maxBarX *= -1
        self.heroBaseline = self.spawningBar.position.y - (self.spawningBar.size.height / 20 + 56.5)
        self.heroStatic.position = CGPointMake(CGRectGetMinX(self.frame) + (self.heroStatic.size.width / 2), self.heroBaseline)
        
        self.block.position = (CGPointMake(CGRectGetMaxX(self.frame) + (self.block.size.width) + 160, self.heroBaseline + -27.25)) // hier plaats ik de random gegenereerde block
        self.blockDouble.position = (CGPointMake(CGRectGetMaxX(self.frame) + (self.block.size.width) + 160, self.heroBaseline + -17.25))
        
        self.origRunningBlockPositionXPoint = self.block.position.x
        
        
        self.block.name = "block"
        self.blockDouble.name = "blockDouble"
        
        blockStatuses["block"] = BlockStatus(isRunning: false, timeGapNextRun: randomBlockSpawn(), currentInterval: UInt32(0))
        blockStatuses["blockDouble"] = BlockStatus(isRunning: false, timeGapNextRun: randomBlockSpawn(), currentInterval: UInt32(0))
        
        
        self.scoreText.text = "0"
        self.scoreText.fontSize = 42
        self.scoreText.position = CGPointMake(CGRectGetMidX(self.frame), -2)
        
        self.blockMaxX = 30 - self.block.size.width / 2
        
        
        self.addChild(self.spawningBar)
        self.addChild(self.heroStatic)
        self.addChild(self.scoreText)
        self.addChild(self.block)
        self.addChild(self.blockDouble)
        }


    func addBG() { // adding the same background func from the GameScene swift file(1st scene)
        var background = SKSpriteNode(imageNamed: "background")
         
            background.size.width = self.frame.size.width
            background.size.height = self.frame.size.height
            addChild(background)
        }
    
    
    
    func randomBlockSpawn() -> UInt32 {
        var range = UInt32(50)...UInt32(200)
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
    }
    
    
    var blockStatuses:Dictionary<String, BlockStatus> = [:]
    


    
    
    
    
    
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if self.onGround {
            self.velocityY = -5.3 // jumping velocity
            self.onGround = false
        }
    }
    
    
    
    
    override func update(currentTime: NSTimeInterval) {
        if self.spawningBar.position.x <= maxBarX {
            self.spawningBar.position.x = self.origRunningFloorPositionXPoint
        }
        
        //Jump
        self.velocityY += self.gravity
        self.heroStatic.position.y -= velocityY
        
        if self.heroStatic.position.y < self.heroBaseline {
            self.heroStatic.position.y = self.heroBaseline
            velocityY = 0.0
            self.onGround = true
        }
        
        
        //move the ground
        spawningBar.position.x -= CGFloat(self.floorSpeed)
        
        
        blockRunner()
    }
    
    func blockRunner() {
        for(block, blockStatus) in self.blockStatuses {
            var thisBlock = self.childNodeWithName(block)
            if blockStatus.shouldRunBlock() {
                //blockStatus.timeGapNextRun = randomBlockSpawn()
                blockStatus.currentInterval = 0
                blockStatus.isRunning = true
            }
            
                        if blockStatus.isRunning {
                if thisBlock!.position.x + (2.1 * blockDouble.size.width) > blockMaxX {
                    thisBlock?.position.x -= CGFloat(self.floorSpeed) //- self.block.size.width
                } else {
                    thisBlock?.position.x += self.origRunningBlockPositionXPoint
                    blockStatus.isRunning = false
                    self.score++
                    if ((self.score % 5) == 0) {
                        self.floorSpeed++
                    }
                    self.scoreText.text = String(self.score)
                }
            } else {
                blockStatus.currentInterval++
            }
        }
    }
    
    
    
    
    
}

















