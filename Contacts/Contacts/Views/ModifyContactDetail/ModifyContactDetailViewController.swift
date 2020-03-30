//
//  ModifyContactDetailViewController.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import UIKit

class ModifyContactDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var modifyContactTableView: UITableView!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    var contactViewMode: ContactUpdateViewMode?
    var imagePickerController: UIImagePickerController?
    var modifyContactViewModel = ModifyContactDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        if contactViewMode == .edit {
            updateProfilePic()
        }
        modifyContactViewModel.reloadView = {(isUpdateSuccessful) in
            if isUpdateSuccessful {
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(animated: true, completion: nil)
                }
            } else {
                //TODO: show alert
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addGradientToBackgroundView()
        registerTableViewCells()
    }
    
    
    @objc func dismissKeyboard() {
           self.view.endEditing(true)
       }
    
    func updateProfilePic() {
        if let contact = modifyContactViewModel.contact {
            profileImageView.kf.setImage(with: URL(string: AppConstants.API.imageBasePath + (contact.profile_pic ?? "")))
        }
    }
    
    func addGradientToBackgroundView()  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundContainerView.frame
        
        gradientLayer.colors = [#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0).cgColor,#colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 0.278119649).cgColor, #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 0.2833369008).cgColor]
        
        backgroundContainerView.layer.addSublayer(gradientLayer)
    }
    
    func registerTableViewCells()  {
        modifyContactTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.contactDetailCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.contactDetailCell)
        modifyContactTableView.tableFooterView = UIView()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func didClickOnCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePickerController = UIImagePickerController()
            imagePickerController?.delegate = self;
            imagePickerController?.sourceType = .photoLibrary
            self.present(imagePickerController!, animated: true, completion: nil)
        }
    }
    
    @IBAction func didClickOnDoneButton(_ sender: Any) {
        var params = [String:Any]()
        for i in 0..<4 {
            let modifyContactCell = modifyContactTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? ContactDetailTableViewCell
            switch i {
            case 0:
                if isInputValid(key: "First Name", value: modifyContactCell?.valueTextField.text ?? "") {
                    params["first_name"] = modifyContactCell?.valueTextField.text ?? ""
                } else {
                    return
                }
            case 1:
                if isInputValid(key: "Last Name", value: modifyContactCell?.valueTextField.text ?? "") {
                    params["last_name"] = modifyContactCell?.valueTextField.text ?? ""
                } else {
                    return
                }
            case 2:
                if isInputValid(key: "Phone Number", value: modifyContactCell?.valueTextField.text ?? "") {
                    params["phone_number"] = modifyContactCell?.valueTextField.text ?? ""
                } else {
                    return
                }
            case 3:
                if isInputValid(key: "Email", value: modifyContactCell?.valueTextField.text ?? "") {
                    params["email"] = modifyContactCell?.valueTextField.text ?? ""
                } else {
                    return
                }
            default:
                break
            }
        }
        params["favorite"] = false
        if contactViewMode == .add {
                    modifyContactViewModel.addContactDetail(params: params)

        } else {
            modifyContactViewModel.updateContactDetail(params: params)
        }
    }
    
    @IBAction func didClickOnCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isInputValid(key: String, value: String) -> Bool {
        if value.count == 0 {
            showAlertWithMessage(message: "\(key) can't be empty.")
        } else if key == "Phone Number" {
            if Helper.isValidEmail(value) {
                return true
            } else {
                showAlertWithMessage(message: "Invalid Email")
            }
        } else if key == "Email" {
            if Helper.validatePhone(value: value) {
                return true
            } else {
                showAlertWithMessage(message: "Invalid Phone Number")
            }
        } else {
            return true
        }
        return false
    }
    
    func showAlertWithMessage(message: String)  {
        let alertController = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {
        }
    }
}

extension ModifyContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modifyContactTableCell = modifyContactTableView.dequeueReusableCell(withIdentifier: AppConstants.ViewIdentifiers.contactDetailCell, for: indexPath) as? ContactDetailTableViewCell
        switch indexPath.row {
        case 0:
            modifyContactTableCell?.keyLabel.text = "First Name"
            modifyContactTableCell?.valueTextField.placeholder = "Enter First Name"
            modifyContactTableCell?.valueTextField.text = contactViewMode == .add ? "" : modifyContactViewModel.contact?.first_name
        case 1:
            modifyContactTableCell?.keyLabel.text = "Last Name"
            modifyContactTableCell?.valueTextField.placeholder = "Enter Last Name"
            modifyContactTableCell?.valueTextField.text = contactViewMode == .add ? "" : modifyContactViewModel.contact?.last_name
        case 2:
            modifyContactTableCell?.keyLabel.text = "mobile"
            modifyContactTableCell?.valueTextField.placeholder = "Enter mobile"
            modifyContactTableCell?.valueTextField.keyboardType = .phonePad
            modifyContactTableCell?.valueTextField.text = contactViewMode == .add ? "" : modifyContactViewModel.contact?.phone_number
        case 3:
            modifyContactTableCell?.keyLabel.text = "email"
            modifyContactTableCell?.valueTextField.placeholder = "Enter email"
            modifyContactTableCell?.valueTextField.keyboardType = .emailAddress
            modifyContactTableCell?.valueTextField.text = contactViewMode == .add ? "" : modifyContactViewModel.contact?.email
        default:
            return modifyContactTableCell!
        }
        return modifyContactTableCell!
    }
}

extension ModifyContactDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        imagePickerController?.dismiss(animated: true, completion: {
            
        })
    }
    
}
