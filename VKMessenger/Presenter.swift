//
//  Presenter.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

protocol Presenter: class
    
{
    
    //определим интерфейс, который будет у всех презентеров
    
    //функция, вызываемая, когда загрузился вью
    
    
    func viewLoaded (view: View) -> Void
    
    // количество секций
    
    
    func numberOfSections ()-> Int
    
    // количество моделей в секции
    
    func numberOfModels (section : Int) -> Int
    
    
    
    // получение моделей
    
    func getModel (indexPath: IndexPath) -> Any
    
}
