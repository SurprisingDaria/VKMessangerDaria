//
//  GetUserOperation.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 24.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class GetUserOperation: Operation
{
    var success: ()->Void
    var failure: (Int) -> Void
    var userIDs: String
    
    
    var internetTask: URLSessionDataTask?
    
    init(userIDs: String, success: @escaping ()->Void, failure: @escaping (Int)-> Void)
    
    {
        self.success = success
        self.failure = failure
        self.userIDs = userIDs
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    
    //мейн всегда асинхронный
    override func main()
    {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getUser(usersIDs: userIDs, success: {(jsonresponse) in
            
            let dataArray = jsonresponse ["response"].arrayValue
            
            let context = CoreDataManager.sharedInstance.privateContext()
            
            
            for i in 0..<dataArray.count
            {
                let item = dataArray[i]
                
                let name = item["first_name"].stringValue + " " + item["last_name"].stringValue
                let id = item["id"].stringValue
                let photo = item["photo_max"].stringValue
                let status  = item["online"].intValue
              
                
                let statusName: Bool
                
                if status == 1
                {
                    statusName = true
                }
                else
                {
                    statusName = false
                }
                
              
           //_ = UserFactory.createOrUpdateUser(id: id, avatarURL: photo, name: name, context: context)
           
            _ = UserUpdateDialogFactory.createOrUpdateDialog(id: id, title: name, dialogAvatar: photo, online: statusName, context: context)
            
            }
            
             _=try? context.save()
            
            if self.isCancelled == false
            {
                self.success()
            }
            else
            {
                // если отменили, то передается пустой массив)
                self.success()
            }
            
            // освободили семафор
            
            semaphore.signal()
            

            
        
            
        }, failure: { (code) in
            
            // освободили семмфор
            semaphore.signal()
            
            self.failure(code)
            
            
        })
        
        
        
        
        
    }
}

