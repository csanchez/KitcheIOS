//
//  ValidationError.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation

struct ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}
