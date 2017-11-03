//
//  ViewControllersFabrique.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

import UIKit

 class ViewControllersFabrique

{
    //программная инициализация контроллера 
    class func returnViewController (identifier: String) -> UIViewController
    
    {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
