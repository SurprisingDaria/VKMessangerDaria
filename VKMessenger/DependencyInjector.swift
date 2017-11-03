//
//  DependencyInjector.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

class DependencyInjector
    
{
    class func obtainPresenter(view: View)
        
    {
        var presenter: Presenter?
        
        
        if view is DialogsViewController
            
        {
            presenter = DialogsPresenter ()
        }
        
        
        if presenter != nil
        {
            
            view.assignPresenter(presenter: presenter!)
            
        }
    }
    
}
