//
//  VkAuthManager.swift
//  VkFeed
//
//  Created by Иван on 29.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import VK_ios_sdk


//MARK: Интерфейс
class VKAuthManager : NSObject
{
    static let sharedInstance = VKAuthManager()
    
    var success : ( () -> Void)!
    var failure : ( () -> Void)!
    weak var controller : UIViewController?
    
    var sdkInstance : VKSdk!
}

//MARK: интерфейс процедур авторизации
extension VKAuthManager
{
    func authorise(withController controller: UIViewController, success: @escaping () -> Void, failure: @escaping ()-> Void)
    {
        if getAccessToken() != nil
        {
            print(getAccessToken())
            success()
            return
        }
        
        self.success = success
        self.failure = failure
        self.controller = controller
        
        sdkInstance = VKSdk.initialize(withAppId: "6039904")
        sdkInstance.uiDelegate = self
        sdkInstance.register(self)
        
        VKSdk.authorize(["friends" , "photos" , "audio" , "video" , "messages" , "wall" , "offline"])
    }
}

//MARK: обработка URL схемы от приложения VK
extension VKAuthManager
{
    func process (url: URL, fromApplication app: String?)-> Bool
    {
       return VKSdk.processOpen(url as URL!, fromApplication: app)
    }
}

//MARK: реализация процедур протоколов VKSDK Delagate, VKSDK UIDelegate
extension VKAuthManager: VKSdkDelegate, VKSdkUIDelegate
{
    func vkSdkUserAuthorizationFailed()
    {
        failure()
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!)
    {
        if let token = result.token
        {
            setAccessToken(token: token.accessToken)
            print("token - \(token.accessToken)")
            success()
        }
        else
        {
            failure()
            print("failure")
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!)
    {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!)
    {
        self.controller?.present(controller, animated: true, completion: nil)
    }
    
}

//MARK: хранение токена
extension VKAuthManager
{
    func setAccessToken(token: String)
    {
        UserDefaults.standard.set(token, forKey: "X-ACCESS-TOKEN")
        UserDefaults.standard.synchronize()
    }
    
    func getAccessToken() -> String?
    {
        //print("ТОКЕН ИЗ ПЗУ - \(UserDefaults.standard.value(forKey: "X-ACCESS-TOKEN") as? String)")
        return UserDefaults.standard.value(forKey: "X-ACCESS-TOKEN") as? String
    }
}
