//
//  LoginViewModel.swift
//  LoginForm
//
//  Created by Prashant Rai on 14/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import Foundation
import UIKit
import CoreData


protocol LoginViewModelDelegate {
    func userLoggedIn()
}

struct LoginViewModel {
    
    var viewModelDelegate: LoginViewModelDelegate?
    func sendValue(from employeeId: String?, password: String?) throws {
        guard let employeeId = employeeId, !employeeId.isEmpty else {
            throw LoginError.idNotEntered
        }
        
        guard let password = password, !password.isEmpty else {
            throw LoginError.passwordNotEntered
        }

        do {
            let user = try getUser(withID: employeeId)
            if user.password == password {
                viewModelDelegate?.userLoggedIn()
            }
            else {
              throw LoginError.invalidPassword
            }
        } catch let error {
            throw error
        }
    }

    func getUser(withID employeeId: String) throws -> User {
        do {
            let users = try CoreDataHelper.shared.getUser(withId: employeeId)
            if users.isEmpty {
                throw LoginError.noRegisteredUser(employeeId: employeeId)
            }
            return users[0]
        } catch let error {
            throw error
        }
    }
    
    
}
