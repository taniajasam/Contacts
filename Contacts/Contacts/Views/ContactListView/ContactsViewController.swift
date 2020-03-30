//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import UIKit
import Kingfisher

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var groupsButton: UIBarButtonItem!
    @IBOutlet weak var addContactButton: UIBarButtonItem!
    @IBOutlet weak var contactsTableView: UITableView!
    private let contactsViewModel = ContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsViewModel.reloadTableData = {
            DispatchQueue.main.async { [weak self] in
                self?.contactsTableView.reloadData()
            }
        }
        
        setCustomViews()
        contactsViewModel.fetchContactList()
        registerTableViewCells()
    }
    
    func setCustomViews() {
        let font = UIFont.systemFont(ofSize: 20);
    addContactButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for:.normal)
    }
    
    func registerTableViewCells() {
        contactsTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.contactListCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.contactListCell)
    }
    
    @IBAction func didClickOnAddContactButton(_ sender: Any) {
        let modifyContactDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.modifyDetailView) as? ModifyContactDetailViewController
        modifyContactDetailVC?.contactViewMode = .add
        modifyContactDetailVC?.modalPresentationStyle = .fullScreen
        self.present(modifyContactDetailVC!, animated: true, completion: nil)
    }
}

extension ContactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        contactsViewModel.contactKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactList = contactsViewModel.contactsDict[contactsViewModel.contactKeys[section]]
        return contactList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactsViewModel.contactKeys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactsViewModel.contactKeys
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactListCell = contactsTableView.dequeueReusableCell(withIdentifier: AppConstants.ViewIdentifiers.contactListCell, for: indexPath) as? ContactListTableViewCell
        if let contactList = contactsViewModel.contactsDict[contactsViewModel.contactKeys[indexPath.section]] {
            contactListCell?.contactNameLabel.text = (contactList[indexPath.row].first_name ?? "") + " " + (contactList[indexPath.row].last_name ?? "")
            contactListCell?.favoriteIcon.isHidden = !(contactList[indexPath.row].favorite ?? false)
            let imageUrl = URL(string: AppConstants.API.imageBasePath + (contactList[indexPath.row].profile_pic ?? ""))
            contactListCell?.contactListImageView.kf.setImage(with: imageUrl)
        }
        return contactListCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contactList = contactsViewModel.contactsDict[contactsViewModel.contactKeys[indexPath.section]] {
            let contactDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.contactDetailView) as? ContactDetailViewController
            contactDetailVC?.contactDetailViewModel.contact = contactList[indexPath.row]
            self.navigationController?.pushViewController(contactDetailVC!, animated: true)
        }
    }
    
}
