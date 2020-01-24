//
//  User+CoreDataProperties.swift
//  LoginForm
//
//  Created by Prashant Rai on 18/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String
    @NSManaged public var password: String
    @NSManaged public var mobileNumber: String?
    @NSManaged public var employeeId: String
    @NSManaged public var email: String
    
    func update(name: String?, email: String?, mobileNumber: String?, employeeId: String?, password: String?) throws {
        guard let employeeName = name else {
            throw RegistrationError.missingEmployeeName
        }
        guard let email = email else {
            throw RegistrationError.missingEmployeeEmail
        }
        guard let employeeId = employeeId else {
            throw RegistrationError.missingEmployeeId
        }
        guard let password = password else {
            throw RegistrationError.missingPassword
        }
    
        self.employeeId = employeeId
        userName = employeeName
        self.mobileNumber = mobileNumber
        self.email = email
        self.password = password
    }
    
}
