//
//  LoginViewController.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController

{

    override func viewDidAppear(_ animated: Bool)
    
    {
        VKAuthManager.sharedInstance.authorise(withController: self, success: {
            
            
        }, failure: {
        })
        
        super.viewDidAppear(animated)
        
        
    }
}
// работа с переходами 

extension LoginViewController

{
    private func performSegue(authSuccess: Bool)
    
    {
        DispatchQueue.main.async
            
        {
            if authSuccess
            {
                self.performSegue(withIdentifier: Constant.SegueNames.kMainTabbarSegueName, sender: self)
            }
        }
    }
    
}
