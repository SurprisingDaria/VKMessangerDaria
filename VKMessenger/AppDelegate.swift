//
//  AppDelegate.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import UIKit
import CoreData


// вызывается первым при старте приложении, отвечает за состояние приложения
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        return VKAuthManager.sharedInstance.process(url: url, fromApplication: sourceApplication)
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    
    {
      var startControllerID = ""
       if  VKAuthManager.sharedInstance.getAccessToken() != nil
       {
        startControllerID = Constant.ViewControllersIdentifiers.kMainTabbarViewControllerIdentifier
        }
        
        else
       {
        startControllerID = Constant.ViewControllersIdentifiers.kLoginViewControllerIdentifier
        }
    
        
        let startController = ViewControllersFabrique.returnViewController(identifier: startControllerID)
        window!.rootViewController = startController
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication)
    
    {
     
        CoreDataManager.sharedInstance.save()
    }

    

}

