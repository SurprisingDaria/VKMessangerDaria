//
//  UsersManager.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 24.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class UsersManager

{
    class func getUsersData (userIDsString: String, success: @escaping()->Void, failure: @escaping(Int)-> Void )
    
    {
        let userOp = GetUserOperation(userIDs: userIDsString, success: { () in
            
            
            success ()
            
            }, failure: {errorCode in
                
                failure(errorCode)
        })
        
        OperationsManager.addOperation(op: userOp, cancellingQueue: true)
    
    
    }
}
