//
//  Utility.swift
//  LoginForm
//
//  Created by Prashant Rai on 19/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import Foundation

struct Utility {
    
    static func isValidMobileNumber(mobileNumber: String?) -> Bool {
        let phonRegEx = "^[+]{0,1}[0-9]{0,4}[-]{0,1}[0-9]{8,12}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phonRegEx)
        let result =  phoneTest.evaluate(with: mobileNumber)
        return result
    }
    
    static func isValidEmail(email: String?) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    static func isStrongPassword(password: String?) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,15}$"
        //        ^                         Start anchor
        //        (?=.*[A-Z].*[A-Z])        Ensure string has one uppercase letters.
        //        (?=.*[!@#$&*])            Ensure string has one special case letter.
        //        (?=.*[0-9].*[0-9])        Ensure string has two digits.
        //        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
        //        .{8,15}                   Ensure string is of length 8 to 15.
        //        $                         End anchor.
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func if_let<T, U>(a: Optional<T>, b: Optional<U>,
                                fn: (T, U) -> (), elseFn: ()->()) {
        var allUnwrapped = false
        if let a = a {
            if let b = b {
                fn(a, b)
                allUnwrapped = true
            }
        }
        if !allUnwrapped {
            elseFn()
        }
    }
    
    static func if_let<T, U, V>(a: Optional<T>, b: Optional<U>,
                         c: Optional<V>, fn: (T, U, V) -> (), elseFn: ()->()) {
        var allUnwrapped = false
        if let a = a {
            if let b = b {
                if let c = c {
                    fn(a, b, c)
                    allUnwrapped = true
                }
            }
        }
        if !allUnwrapped {
            elseFn()
        }
    }
    
    static func performUIUpdate(closure:@escaping () -> ()) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}



