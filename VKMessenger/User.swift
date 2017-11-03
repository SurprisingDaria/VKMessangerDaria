//
//  User.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 20.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject

{
    @NSManaged var id: String
    @NSManaged var avatarURL: String
    @NSManaged var name: String
   
}
