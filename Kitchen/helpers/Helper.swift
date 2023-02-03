//
//  Helper.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//

import Foundation

import UIKit


func userMessage(alertTitle : String, message : String, actionTitle : String, vc : UIViewController) {
    let userAlert = UIAlertController.init(title: alertTitle, message: message, preferredStyle: .alert)
    userAlert.addAction(UIAlertAction.init(title: actionTitle, style: .default))
    vc.present(userAlert, animated: true)
}
