//
//  LoginViewController.swift
//  LoginForm
//
//  Created by Prashant Rai on 14/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {

    @IBOutlet weak var employeeIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newUserButton: UIButton!
    
    lazy var loginViewModel: LoginViewModel = {
        var viewModel = LoginViewModel()
        viewModel.viewModelDelegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.keyboardDismissMode = .interactive
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        do {
            try loginViewModel.sendValue(from: employeeIdTextField.text, password: passwordTextField.text)
        }
        catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }

}

extension LoginViewController: LoginViewModelDelegate {
    func userLoggedIn() {
        self.employeeIdTextField.text = ""
        self.passwordTextField.text = ""
        self.showAlert(message: "Login Success")
    }

}
