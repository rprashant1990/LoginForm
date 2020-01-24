//
//  RegisterViewController.swift
//  LoginForm
//
//  Created by Prashant Rai on 14/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {

    @IBOutlet weak var employeeIDTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    
    lazy var registerViewModel: RegisterViewModel = {
        var viewModel = RegisterViewModel()
        viewModel.viewModelDelegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.sectionHeaderHeight = 0
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.keyboardDismissMode = .interactive
        
        self.navigationController?.navigationBar.tintColor = Constant.themeColor
        let textAttributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor(named: "ThemeColor") as Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        do {
            try registerViewModel.sendValues(with: employeeIDTextField.text, name: nameTextField.text, mobileNumber: mobileNumberTextField.text, email: emailTextField.text, password: passwordTextField.text, conformPassword: conformPasswordTextField.text)
        } catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func fetchAllRecord(_ sender: Any) {
        do {
            try _ = registerViewModel.getAllUsers()
        } catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }
    
}

extension RegisterViewController: RegisterViewModelDelegate {
    func userRegistered() {
        self.showAlert(message: "User Registration Successful")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension UIViewController {
    func showAlert(title: String = "", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
