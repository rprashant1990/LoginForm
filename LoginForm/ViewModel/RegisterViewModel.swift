//
//  RegisterViewModel.swift
//  LoginForm
//
//  Created by Prashant Rai on 14/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol RegisterViewModelDelegate {
    func userRegistered()
}

struct RegisterViewModel {
  
    var viewModelDelegate: RegisterViewModelDelegate?
    
    func sendValues(with employeeId: String?, name: String?, mobileNumber:String?, email:String?, password:String?, conformPassword:String?) throws {
        guard let employeeId = employeeId, employeeId.count > 0 else {
            throw RegistrationError.missingEmployeeId
        }
        
        guard let name = name, !name.isEmpty else {
            throw RegistrationError.missingEmployeeName
        }
        
        guard let email = email, !email.isEmpty else {
            throw RegistrationError.missingEmployeeEmail
        }
        
        guard let password = password, !password.isEmpty else {
            throw RegistrationError.missingPassword
        }
        
        guard let conformPassword = conformPassword, !conformPassword.isEmpty else {
            throw RegistrationError.missingConformPassword
        }
        
        guard password == conformPassword else {
            throw RegistrationError.passwordMismatch
        }
        
        if let mobileNumber = mobileNumber {
            guard Utility.isValidMobileNumber(mobileNumber: mobileNumber) else {
                throw RegistrationError.invalidMobileNumber
            }
        }
        
        guard Utility.isValidEmail(email: email) else {
            throw RegistrationError.invalidEmail
        }
        
        guard Utility.isStrongPassword(password: password) else {
            throw RegistrationError.notStrongPassword
        }
        
        do {
            let users = try CoreDataHelper.shared.getUser(withId: employeeId)
            if users.count > 0 {
                throw RegistrationError.userAlredyExist
            }
            try CoreDataHelper.shared.addUser(withEmployeeId:employeeId, name: name, mobileNumber: mobileNumber, email: email, password: password)
            viewModelDelegate?.userRegistered()
        }
        catch let error {
            throw error
        }
    }
    
    func getAllUsers() throws -> [User] {
        do {
            let users = try CoreDataHelper.shared.getAllUsers()
            return users
        } catch let error {
            throw error
        }
    }
    
}
