//
//  GetDialogsOperation.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class GetDialogsOperation: Operation
    
{
    
    var success: (String)-> Void
    var failure: (Int) -> Void
    
    
    
    var internetTask: URLSessionDataTask?
    
    init(success:@escaping (String)-> Void, failure: @escaping (Int) -> Void)
        
    {
        self.success = success
        self.failure = failure
     
       
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    //мейн всегда асинхронный
    override func main()
    {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        //из API-Wrapper приходит объект класса интернет таск, если операция отменяется, то мы отменяем запрос в интернет. 
        internetTask = API_WRAPPER.getMessages(success: { (jsonresponse) in
            
      
            let data = jsonresponse ["response"]
            
            let context = CoreDataManager.sharedInstance.privateContext()
            
            let itemsArray = data ["items"].arrayValue
            
            var userIDsString = ""
            
            for i in 0..<itemsArray.count
            {
                // критическая точка, проверяем, отменена операция или нет
                if self.isCancelled
                {
                    //выходим из цикла
                    break
                }
                
                let item  = itemsArray[i]
                
                let dialog = item["message"]
                let date = dialog["date"].intValue
                let title = dialog["title"].stringValue
                var messageTitle = "..."
                let body = dialog["body"].stringValue
                var id: String = ""
                var type =  ""
                let userIDsArray = dialog["chat_active"].arrayValue
   
                let userIDsStringArray = userIDsArray.flatMap{String(describing: $0)}
                
//                userIDsString = userIDsStringArray.joined(separator: ",")
                
            
                
                
                let senderUserID = dialog["user_id"].stringValue
                
                
                
                if title == "..."
                
                {
                    messageTitle = dialog["user_id"].stringValue
                }
                
                else
                {
                    messageTitle  = dialog["title"].stringValue
                }
                
               
                if let chat_id  = dialog["chat_id"].int64
                {
                    id = (String)((chat_id)*(-1))
                    type = "чат"
                }
                else
                {
                    let companionID = dialog["user_id"].int64Value
                    id = (String)(companionID)
                    userIDsString = userIDsString + id + ","
                    type = "диалог"
                }
                
                _ = DialogFactory.createOrUpdateDialog(id: id, snippet: body, title: messageTitle, date: Date(timeIntervalSince1970: TimeInterval(date)), dialogAvatar: "", senderUserID: senderUserID, online: false, type: type, userIDsString: userIDsString, context: context)
                
                
            }
            _=try? context.save()
            
            if self.isCancelled == false
            {
                self.success(userIDsString)
            }
            else
            {
                // если отменили, то передается пустой массив)
                self.success("")
            }
            
            // освободили семафор
            
            semaphore.signal()
            
        }, failure: { (code) in
            
            // освободили семмфор
            semaphore.signal()
            
            self.failure(code)
            
            
        })
        //если у нас ничего не возвращается, семафор всегда ждет
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
