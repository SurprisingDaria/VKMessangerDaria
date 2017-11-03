//
//  DialogsViewController.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import UIKit

class DialogsViewController: UIViewController

{

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: Presenter?
    
    let kDialogNIB = UINib(nibName: "DialogTableViewCell", bundle: nil)
    let kDialogCellReuseidentifier = "kDialogCellReuseidentifier"
    
    
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        tableView.register(kDialogNIB, forCellReuseIdentifier: kDialogCellReuseidentifier)

    }
    
    override func viewWillAppear(_ animated: Bool)
        
    {
        if presenter == nil
        {
            DependencyInjector.obtainPresenter(view: self)
        }
        
        super.viewWillAppear(animated)
    }
    
}

extension DialogsViewController: DialogsView
    
{
    func assignPresenter (presenter: Presenter) -> Void
        
    {
        self.presenter = presenter
        presenter.viewLoaded(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func reloadData ()-> Void
        
    {
        tableView.reloadData()
    }
    
    //включение лоадера
    func addLoader ()->Void
        
    {
        activityIndicator.startAnimating()
    }
    
    // выключение лоадера
    
    func removeLoader () -> Void
        
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
           self.activityIndicator.stopAnimating()
        }
    }
    
    //коды ошибок интернета
    
    func handleInternetErrorCode (code: Int)-> Void
        
    {
        let alertController = UIAlertController(title: "Ошибка", message: "нет соединения с интернетом", preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func beginUpdates()
    {
        tableView.beginUpdates()
    }
    
    func endUpdates ()
    {
        tableView.endUpdates()
    }
    
    func insert (at: [IndexPath])
        
    {
        tableView.insertRows(at: at, with: .fade)
    }
    
    func move (at: IndexPath, to: IndexPath)
        
    {
        tableView.moveRow(at: at, to: to)
    }
    
    func reload (at: [IndexPath])
    {
        tableView.reloadRows(at: at, with: .fade)
    }
    
    func delete (at: [IndexPath])
        
    {
        tableView.deleteRows(at: at, with: .fade)
    }
    
    
}

//получение данных
extension DialogsViewController: UITableViewDataSource, UITableViewDelegate
    
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (presenter?.numberOfSections())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (presenter?.numberOfModels(section: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dialog = presenter?.getModel(indexPath: indexPath) as! Dialog
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kDialogCellReuseidentifier, for: indexPath) as? DialogTableViewCell
        
        cell?.configureSelf(dialog: dialog)
        if let cell = cell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
}




