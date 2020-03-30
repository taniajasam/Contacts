//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contactFullNameLabel: UILabel!
    @IBOutlet weak var contactDetailTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    var contactDetailViewModel = ContactDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        customiseNavigationBar()
        addGradientToBackgroundView()
        contactDetailViewModel.reloadView = {
            DispatchQueue.main.async { [weak self] in
                self?.setContactDetails()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactDetailViewModel.fetchContactDetail()
    }
    
    func customiseNavigationBar()  {
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 1)

        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didClickOnEditButton))
        self.navigationItem.rightBarButtonItem  = editButtonItem
    }
    
    @objc func didClickOnEditButton() {
        let modifyContactDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.modifyDetailView) as? ModifyContactDetailViewController
        modifyContactDetailVC?.contactViewMode = .edit
        if let contactDetail = contactDetailViewModel.contactDetail {
            modifyContactDetailVC?.modifyContactViewModel.contact = contactDetail
        }
        modifyContactDetailVC?.modalPresentationStyle = .fullScreen
        self.present(modifyContactDetailVC!, animated: true, completion: nil)
    }
    
    func addGradientToBackgroundView()  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundContainerView.frame
        
        gradientLayer.colors = [#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0).cgColor, #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 0.278119649).cgColor, #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 0.278119649).cgColor]
        
        backgroundContainerView.layer.addSublayer(gradientLayer)
    }
    
    func registerTableViewCells() {
        contactDetailTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.contactDetailCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.contactDetailCell)
        contactDetailTableView.tableFooterView = UIView()
    }
    
    func setContactDetails() {
        profileImageView.kf.setImage(with: URL(string: AppConstants.API.imageBasePath + (contactDetailViewModel.contactDetail?.profile_pic ?? "")))
        contactFullNameLabel.text = (contactDetailViewModel.contactDetail?.first_name ?? "") + " " + (contactDetailViewModel.contactDetail?.last_name ?? "")
        favoriteButton.isSelected = contactDetailViewModel.contactDetail?.favorite ?? false
        contactDetailTableView.reloadData()
    }
    
    
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contactDetailViewModel.contactDetail != nil {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactDetailCell = contactDetailTableView.dequeueReusableCell(withIdentifier: AppConstants.ViewIdentifiers.contactDetailCell, for: indexPath) as? ContactDetailTableViewCell
        contactDetailCell?.valueTextField.isUserInteractionEnabled = false
        switch indexPath.row {
        case 0:
            contactDetailCell?.keyLabel.text = "mobile"
            contactDetailCell?.valueTextField.text = contactDetailViewModel.contactDetail?.phone_number
            
        case 1:
            contactDetailCell?.keyLabel.text = "email"
            contactDetailCell?.valueTextField.text = contactDetailViewModel.contactDetail?.email
        default:
            return contactDetailCell!
        }
        return contactDetailCell!
    }
}
