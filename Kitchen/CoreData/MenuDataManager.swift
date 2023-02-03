//
//  MenuDataManager.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//




import Foundation
import CoreData

class MenuDataManager{

    private var menus : [Menu] = []
    private var context : NSManagedObjectContext
    
    //Método para crear una instancia de tipo Task
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    func fetch() -> [Menu] {
        do {
            self.menus = try self.context.fetch(Menu.fetchRequest())
        }
        catch{
            print("err: ", error)
            return []
        }
        return self.menus
    }
    
    
    
    func getMenu(at index : Int) -> Menu {
        return self.menus[index]
    }
    
    /*func saveUser(name:String, email:String, address:String){
            self.user = User(context: self.context)
            self.user.setValue(name, forKey: #keyPath(User.name))
            self.user.setValue(email, forKey: #keyPath(User.email))
            self.user.setValue(address, forKey: #keyPath(User.address))
    }*/
    
    
    
    
    
}





