//
//  Dialog.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation
import CoreData

class Dialog: NSManagedObject

{
    //управляемое св-во - записывается на ПЗУ - узнаем о его изменениях
    @NSManaged var id : String
    @NSManaged var snippet: String
    @NSManaged var title: String
    @NSManaged var date: Date
    @NSManaged var dialogAvatar: String
    @NSManaged var senderUserID: String
    @NSManaged var online: Bool
    @NSManaged var type: String 
    @NSManaged var userIDsString: String
    
}
