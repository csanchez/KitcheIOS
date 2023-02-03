//
//  EmptyValidator.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//

import Foundation
//
//  RFCValidator.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation

class EmptyValidator: ValidatorConvertible{
    
    func validated(_ value: String?) throws -> String {
        if value == "" || value == nil{
            throw ValidationError("Campo vacío")
        }
        return value!
            
    }
    

}
