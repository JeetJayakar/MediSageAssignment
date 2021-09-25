//
//  LoginViewModel.swift
//  MedisageAssignment
//
//  Created by Jeet Jaykar on 24/09/21.
//

import Foundation

class LoginViewModel {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password : String) -> Bool{
        if password.count >= 8 && password.count <= 15{
            return true
        }
        return false
    }
}
