//
//  UserFactory.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation
import CoreData

class UserFactory
{
    class func createOrUpdateUser (id: String,
                                     avatarURL: String,
                                     name: String,
                                     context: NSManagedObjectContext
        
        // это контекст, в который вмы выгружваем этот диалог
        //id здесь первичный ключ
        ) -> User
    {
        //шаблон  - парадигма ООП - определение типа данных (любого) - шире, чем обычный  тип данных - декларирует любой тип  - описываем тип, который возвращает Fetch Request
        // это объект фетч реквеста  - возращает массив объектов - оборачивает запрос в контекст
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        //%@  - строковая константа в С
        //хотим выгрузить сущности диалога с указанным индикатором - предикат показывает, какие модели хотим создать. Это неизменный первичный ключ
        fetchRequest.predicate = NSPredicate(format: "id=%@", id)
        
        //принимает на вход предикат, делаем запрос в заданный контекст
        
        let fetchResults = try? context.fetch(fetchRequest) as! [User]
        
        // update
        if fetchResults!.count != 0
        {
            // что-то нашли - в кор дате лежит диалог  - значит его нужно обновить. ID обновлять не нужно, он постоянный
            
            print ("update")
            let user  = fetchResults![0]
            
            
            user.avatarURL = avatarURL
            user.name = name
            
        
            
            return user
            
            
        }
            // create
        else
        {
            
            print ("create")
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            
           
            user.avatarURL = avatarURL
            user.id = id
            user.name = name
            
            return user
        }
        
    }

}
