//
//  ViewController.swift
//  Kitchen
//
//  Created by Tecnologias iis on 01/02/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    @IBAction func showRegisterView(_ sender: Any) {
        self.performSegue(withIdentifier: "show", sender: self)
    }


}

