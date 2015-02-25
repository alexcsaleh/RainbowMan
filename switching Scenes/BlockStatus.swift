//
//  BlockStatus.swift
//  Testing the action
//
//  Created by Alexander Saleh on 2/23/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//

import Foundation
import SpriteKit

class BlockStatus {
    var isRunning = false
    var timeGapNextRun = UInt32(0) // time you need to wait until next run
    var currentInterval = UInt32(0)
    init(isRunning:Bool, timeGapNextRun:UInt32, currentInterval:UInt32) {
        self.isRunning = isRunning
        self.timeGapNextRun = timeGapNextRun
        self.currentInterval = currentInterval
        }
    func shouldRunBlock() -> Bool {
        return self.currentInterval > self.timeGapNextRun
    }
    
}