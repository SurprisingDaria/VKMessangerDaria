//
//  DialogsPresenter.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import Foundation

import CoreData

class DialogsPresenter: NSObject, Presenter, NSFetchedResultsControllerDelegate

    
{
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        
        let context = CoreDataManager.sharedInstance.managedObjectContext
        // entity - это модель? описание модели для фрс
        
        let entity = NSEntityDescription.entity(forEntityName: "Dialog", in: context)
        
        //самый старый наверху
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let request = NSFetchRequest<NSFetchRequestResult>()
        
        request.entity = entity
        request.sortDescriptors = [sortDescriptor]
        
        //фрс поддерживает разбитие модели на секции
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //последовательная процедура, не параллельная - заполняет контроллер данными, когда дергается
        _ = try? controller.performFetch()
        
        controller.delegate = self
        return controller
        
    }()
    
    weak var view: DialogsView?
    
    
    //функция, вызываемая, когда загрузился вью
    
    
    func viewLoaded (view: View) -> Void
        
    {
        self.view = view as! DialogsView
        
        getData()
    }
    
    
    
    // количество секций
    
    
    func numberOfSections ()-> Int
        
    {
        return  1
    }
    
    // количество моделей в секции
    
    func numberOfModels (section : Int) -> Int
    {
        
        
        if let fetchedObjects = fetchedResultsController.fetchedObjects
        {
            return fetchedObjects.count
        }
        
        return 0
        
    }
    
    
    
    
    func getModel (indexPath: IndexPath) -> Any
        
    {
        return fetchedResultsController.object(at: indexPath)
        
    }
    
    private func getData ()
        
    {
        view?.addLoader()
        
        DialogsManager.getDialogsData(success: { [weak self](userIDs) in
            
                UsersManager.getUsersData(userIDsString: userIDs, success:
                {
                        self?.view?.removeLoader()
                        
                }, failure: { (code) in
                    
                    self?.view?.removeLoader()
                })
          

            
            
            }, failure: {[weak self] (code) in
                
                self?.view?.removeLoader()
                
        })
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        view?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        view?.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?)
        
    {
        
        if type == .insert
        {
            print ("insert")
            
            view?.insert(at: [newIndexPath!])
            
            if type == .move
            {
                print ("move")
                
                view?.move(at: indexPath!, to: newIndexPath!)
            }
            if type == .update
            {
                print ("update")
                
                view?.reload(at: [indexPath!])
            }
            if type == .delete
            {
                print ("delete")
                
                view?.delete(at: [indexPath!])
            }
            
        }
    }
}
