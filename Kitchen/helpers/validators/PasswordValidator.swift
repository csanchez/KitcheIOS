//
//  RFCValidator.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation

class PasswordValidator: ValidatorConvertible{
    
    func validated(_ value: String?) throws -> String {
        if value == "" || value == nil{
            throw ValidationError("Contraseña inválida")
        }
        return value!
            
    }
    
    
    
    
}
