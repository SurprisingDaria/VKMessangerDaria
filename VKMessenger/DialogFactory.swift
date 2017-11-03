//
//  DialogFactory.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

import CoreData

class DialogFactory

{
    class func createOrUpdateDialog (id: String,
                                     snippet: String,
                                     title: String,
                                     date: Date,
                                     dialogAvatar: String,
                                     senderUserID: String,
                                     online: Bool,
                                     type: String,
                                     userIDsString: String,
                                     context: NSManagedObjectContext
        
        // это контекст, в который вмы выгружваем этот диалог
        //id здесь первичный ключ
        ) -> Dialog
    {
        //шаблон  - парадигма ООП - определение типа данных (любого) - шире, чем обычный  тип данных - декларирует любой тип  - описываем тип, который возвращает Fetch Request
        // это объект фетч реквеста  - возращает массив объектов - оборачивает запрос в контекст
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dialog")
        
        //%@  - строковая константа в С
        //хотим выгрузить сущности диалога с указанным индикатором - предикат показывает, какие модели хотим создать
        fetchRequest.predicate = NSPredicate(format: "id=%@", id)
        
        //принимает на вход предикат, делаем запрос в заданный контекст
        
        let fetchResults = try? context.fetch(fetchRequest) as! [Dialog]
        
        // update
        if fetchResults!.count != 0
        {
            // что-то нашли - в кор дате лежит диалог  - значит его нужно обновить. ID обновлять не нужно, он постоянный
            
            print ("update")
            let dialog  = fetchResults![0]
            
            dialog.date = date
            dialog.snippet = snippet
            dialog.title  = title
            dialog.dialogAvatar = dialogAvatar
            dialog.senderUserID = senderUserID
            dialog.online = online
            dialog.type = type
            dialog.userIDsString = userIDsString
            
            return dialog
            
            
        }
            // create
        else
        {
            
            print ("create")
            let dialog = NSEntityDescription.insertNewObject(forEntityName: "Dialog", into: context) as! Dialog
            
            dialog.date = date
            dialog.snippet = snippet
            dialog.title  = title
            dialog.dialogAvatar = dialogAvatar
            dialog.senderUserID = senderUserID
            dialog.online = online
            dialog.type = type
            dialog.userIDsString = userIDsString
            dialog.id = id
            
            
            
            return dialog
        }
        
    }

}
