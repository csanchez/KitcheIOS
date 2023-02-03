//
//  NewMenuViewController.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//

import UIKit

class NewMenuViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var menuNameTextField: UITextField!
    @IBOutlet var descNameTextField: UITextField!
    
    
    
    var menu: Menu?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuNameTextField.delegate = self
        self.descNameTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func newMenuAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showMenuSegue", sender: self)
    }
    
    @IBAction func taskCancelButtonPressed(_ sender: UIBarButtonItem) {
            let isModal = presentingViewController is UINavigationController

            if isModal  {
                self.dismiss(animated: true)
            }
            else{
                navigationController?.popViewController(animated: true)
            }
        }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        print("shouldPerformSegue")
        do {
            let name = try self.menuNameTextField.validatedText(validationType: ValidatorType.empty)
            let desc = try self.descNameTextField.validatedText(validationType: ValidatorType.empty)
            
            perform = true
        } catch let _ as ValidationError {
            userMessage(alertTitle: "Atención", message: "Escribe un título para la actividad", actionTitle: "Ok", vc: self)
        }
                
        catch {
            print("other error")
        }
        return perform
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MenusViewController
        menu?.name = menuNameTextField.text
        menu?.descripcion = descNameTextField.text
        destination.currentMenu = menu
    }
    

}
