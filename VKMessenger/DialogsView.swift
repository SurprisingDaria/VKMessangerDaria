//
//  DialogsView.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

import Foundation

protocol DialogsView: View
    
{
    func beginUpdates()
    
    func endUpdates ()
    
    func insert (at: [IndexPath])
    
    func move (at: IndexPath, to: IndexPath)
    
    func reload (at: [IndexPath])
    
    func delete (at: [IndexPath])
    
    
    
}
