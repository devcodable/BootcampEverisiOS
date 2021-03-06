//
//  ContactDetailViewController.swift
//  EverisTask
//
//  Created by David Cuñado Gil on 2/8/21.
//

import UIKit

protocol ContactDetailViewControllerProtocol {
    func reloadDataModel()
}

class ContactDetailViewController: UIViewController {
    
    // MARK: - ID
    var presenter: ContactDetailPresenterProtocol?
    
    // MARK: IBOutlets
    @IBOutlet weak var contactDetailTV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.getDataModel()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.contactDetailTV.delegate = self
        self.contactDetailTV.dataSource = self
        self.contactDetailTV.register(UINib(nibName: "ContactDetailCell", bundle: nil), forCellReuseIdentifier: "ContactDetailCell")
    }
}

extension ContactDetailViewController: ContactDetailViewControllerProtocol {
    func reloadDataModel() {
        self.contactDetailTV.reloadData()
    }
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellContactos = self.contactDetailTV.dequeueReusableCell(withIdentifier: "ContactDetailCell", for: indexPath) as! ContactDetailCell
        if let modelData = self.presenter?.informationData(){
            cellContactos.configCell(model: modelData)
        }
        return cellContactos
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
