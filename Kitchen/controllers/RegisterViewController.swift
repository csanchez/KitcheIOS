//
//  RegisterViewController.swift
//  Kitchen
//
//  Created by Tecnologias iis on 01/02/23.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmationTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    
    
    
    var viewHeight = 0.0
    
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideSpinner()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmationTextField.delegate = self
        
        viewHeight = self.view.frame.size.height
        //self.user =  User(context: self.context)

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
    
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        loadingView.isHidden = true
    }
    
    private func showAlertAndEnableView(title:String, message:String){
        DispatchQueue.main.async {
            self.registerButton.isEnabled = true
            self.hideSpinner()
        }
        
        self.showAlert(title:title, message: message);
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
            passwordConfirmationTextField.becomeFirstResponder()
        }
       // return textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
        self.view.frame.size.height = (viewHeight - keyboardSize.height)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
     // self.view.frame.origin.y = 0
        self.view.frame.size.height = viewHeight
    }
    
    
    
    
    @IBAction func register(_ sender: Any) {
        
        self.registerButton.isEnabled = false
        self.showSpinner()
        do {
                
            
            let email = try self.emailTextField.validatedText(validationType: ValidatorType.email)
            let password = try self.passwordTextField.validatedText(validationType: ValidatorType.password)
            let name = try self.nameTextField.validatedText(validationType: ValidatorType.email)
            
            
            
            let url = URL(string: "https://notificaciones.sociales.unam.mx/api/kitchen/auth/register")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")


            let params = ["kuser" : ["email":email, "password_digest": password, "name": name ]] //as Dictionary<String, String>

            guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }


            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // ensure there is no error for this HTTP response
                guard error == nil else {
                    print ("error: \(error!)")
                    //throw AppError.customError(message: "Ocurrio un error indesperado")
                   
                    self.showAlertAndEnableView(title: "Error", message: "ocurrio un error desconocido")
                    return
                }
                
                // ensure there is data returned from this HTTP response
                guard let content = data else {
                    print("No data")
                    //throw AppError.customError(message: "No hay datos en la respuesta")
                    
                    self.showAlertAndEnableView(title: "Error", message: "No hay datos en la respuesta")
                    return
                }
                
                
                
                
                
                
                // serialise the data / NSData object into Dictionary [String : Any]
               guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                   
                   self.showAlertAndEnableView(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
                    //throw AppError.invalidJsonResponse
                    return
                }
                
                print("gotten json response dictionary is \n \(json)")
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    print("status",httpResponse.statusCode)
                    if httpResponse.statusCode == 401 {
                        
                        self.showAlertAndEnableView(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida")
                        //throw AppError.invalidUserOrPassword
                        return
                    }
                        
                }
                
                print("json")
                print(json)
                let defaults = UserDefaults.standard
                let user = json["user"] as? [String:Any]
                
                let token =  json["token"]
                let email =  user?["email"]
                let name =  user?["name"]
                let menus =  user?["menus"]
                
                
                
                defaults.set(true, forKey: "loggedIn")
                defaults.set(token!, forKey: "token")
                
                /*defaults.set(token!, forKey: "token")
                defaults.set(email!, forKey: "email")
                defaults.set(name!, forKey: "name")*/
                
                /*self.user!.setValue(name, forKey: #keyPath(User.name))
                self.user!.setValue(email, forKey: #keyPath(User.email))¿*/
                
                self.user?.name = name as? String
                self.user?.email = email as? String
                
                
                //AppDelegate.sharedAppDelegate.saveContext()
                do{
                    try self.context.save()
                    
                    DispatchQueue.main.async {
                                       // self.loginButton.isEnabled = true
                    self.hideSpinner()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                                    }
                } catch{
                    print("Error: ", error)
                    self.showAlert(title: "Core data", message: "no fue posible al macenar los datos")
                }
                
                
                
                
               
            }
            
            //self.view.makeToast("This is a piece of toast")
            // execute the HTTP request
            task.resume()
                
                
        } catch let validationError as ValidationError {
            showAlert(title: "Error", message: validationError.message)
            self.registerButton.isEnabled = true
            self.hideSpinner()
        }
        
        catch {
            print("other error")
        }
    }
    
}
