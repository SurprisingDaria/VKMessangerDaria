//
//  OperationsManager.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class OperationsManager
    
{
    private static let businessLogicOperationQueue = OperationQueue()
    
    class func addOperation(op: Operation, cancellingQueue: Bool)
    {
        //количество параллельных операций
        businessLogicOperationQueue.maxConcurrentOperationCount  = 1
        if cancellingQueue
        {
            businessLogicOperationQueue.cancelAllOperations()
        }
        businessLogicOperationQueue.addOperation(op)
    }
    
}
