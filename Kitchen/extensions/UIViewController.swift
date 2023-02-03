
import UIKit


extension UIViewController{
    
    
    func showAlert(title: String, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    /*private func showASpinner(_ activityIndicator: UIActivityIndicatorView,_ loadingView: UIView) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        loadingView.isHidden = false
    }

    private func hideASpinner(_ activityIndicator: UIActivityIndicatorView,_ loadingView: UIView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        loadingView.isHidden = true
    }
    */
    
    
    
    
}



