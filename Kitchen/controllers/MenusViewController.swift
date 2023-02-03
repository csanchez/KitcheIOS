//
//  MenusViewController.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//

import UIKit

class MenusViewController: UIViewController {
    

    var menus : [Menu] = []
    var currentMenu : Menu?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dataManager = MenuDataManager(context: context)
        menus = dataManager.fetch()
        
        print(menus)

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "showMenuSegue" {
            let destination = segue.destination as! MenuViewController
            //let selectedIndexPath = toDoListTableView.indexPathForSelectedRow!
            //destination.toDoDetailTask = tasks[selectedIndexPath.row]
        }
    }

    
    
    
    
    
    
    
    @IBAction  func unWindFromNewMenu(segue: UIStoryboardSegue ){
        let source = segue.source as! NewMenuViewController
        currentMenu = source.menu
            do{
                try context.save()
            }
            catch{
                print("error al salvar",error)
            }
            
            let dataManager = MenuDataManager(context: context)
            menus = dataManager.fetch()
        print(menus)
            //self.toDoListTableView.reloadData()
    }
}
