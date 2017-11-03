

import Foundation
import SwiftyJSON

class API_WRAPPER

{
    class func getMessages(success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://api.vk.com/method/messages.getDialogs?access_token=\(VKAuthManager.sharedInstance.getAccessToken()!)&count=50&v=5.62"
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
            {data , response, error in
                
                self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
                
        })
        
        task.resume()
        return task
    }


    class func getUser(usersIDs: String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://api.vk.com/method/users.get?user_ids=\(usersIDs)&fields=photo_max,online&access_token=\(VKAuthManager.sharedInstance.getAccessToken()!)&v=5.63"
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
            {data , response, error in
                
                self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
                
        })
        
        task.resume()
        return task
    }
}

extension API_WRAPPER
{
    class func getChatHistory(offset: Int, id: String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://api.vk.com/method/messages.getHistory?user_id=\(id)&offset=\(offset)&access_token=\(VKAuthManager.sharedInstance.getAccessToken()!)&count=20&rev=0&v=5.63"
        
        // print("запрос - \(urlString)")
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
            {data , response, error in
                
                self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
                
        })
        
        task.resume()
        return task
    }
}



//MARK: -обработчик ответов из интернета
extension API_WRAPPER
{
    class func genericCompletionCallback (
        data : Data? ,
        response : URLResponse? ,
        error : Error? ,
        success : (JSON) -> Void ,
        failure : (Int) -> Void
        )
    {
        if (error != nil)
        {
            failure( (error as! NSError).code )
            return
        }
        
        if let rawData = data
        {
            do
            {
                let rawJSON = try JSONSerialization.jsonObject(with: rawData, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let json = JSON( rawJSON)
                
                success(json)
                return
            }
            catch
            {
                failure(-1)
                return
            }
            
        }
        failure(-1)
        
    }
}



