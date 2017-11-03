//
//  DialogsManager.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class DialogsManager

{
  
    
    class func getDialogsData (success: @escaping(String) -> Void, failure: @escaping (Int) ->Void)
    {
        let dialogOp = GetDialogsOperation( success: { (result) in
            
            
            success (result)
            
        }, failure: {errorCode in
            
            failure(errorCode)
        })
        
        //отменяет предыдущие операции
        OperationsManager.addOperation(op: dialogOp, cancellingQueue: true)
    }

}
