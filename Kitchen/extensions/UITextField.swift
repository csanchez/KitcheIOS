//
//  UITextFieldValidation.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation
import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
