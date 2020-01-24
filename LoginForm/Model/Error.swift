//
//  LoginError.swift
//  LoginForm
//
//  Created by Prashant Rai on 18/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case idNotEntered
    case invalidPassword
    case noRegisteredUser(employeeId: String)
    case passwordNotEntered
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .idNotEntered:
            return NSLocalizedString("Employee Id is missing.", comment: "")
        case .passwordNotEntered:
            return NSLocalizedString("Password field data is missing.", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Invalid Password.", comment: "")
        case .noRegisteredUser(let employeeId):
            return NSLocalizedString( #"No user registerd with employee Id "\#(employeeId)"."#, comment: "")
        }
    }
}


enum RegistrationError: Error {
    case missingEmployeeId
    case missingEmployeeName
    case missingEmployeeEmail
    case missingPassword
    case missingConformPassword
    case passwordMismatch
    case invalidMobileNumber
    case invalidEmail
    case notStrongPassword
    case userAlredyExist
    case creationError
}

extension RegistrationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingEmployeeId:
            return NSLocalizedString("Employee Id is missing.", comment: "")
        case .missingEmployeeName:
            return NSLocalizedString("Employee name is missing.", comment: "")
        case .missingEmployeeEmail:
            return NSLocalizedString("Employee email address is missing.", comment: "")
        case .missingPassword:
            return NSLocalizedString("Password field data is missing.", comment: "")
        case .missingConformPassword:
            return NSLocalizedString("Conform Password.", comment: "")
        case .passwordMismatch:
            return NSLocalizedString("Password mismatch.", comment: "")
        case .invalidMobileNumber:
            return NSLocalizedString("Invalid mobile number.", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid email address.", comment: "")
        case .notStrongPassword:
            return NSLocalizedString("Ensure password has 8 to 15 letters, 1 uppercase, 1 special case, 2 digits, 3 lowercase letters", comment: "")
        case .userAlredyExist:
            return NSLocalizedString("User already exist with same employee Id.", comment: "")
        case .creationError:
            return NSLocalizedString("Failed to create a new User.", comment: "")
        }
    }
}


enum ImageDownloadError: Error {
    case urlError
    case networkUnavailable
    case wrongDataFormat
    case missingData
    case creationError
}
