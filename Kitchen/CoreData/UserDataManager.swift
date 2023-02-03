//
//  UserDataManager.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//


import Foundation
import CoreData

class UserDataManager{
    
   

    //private var users : [User] = []
    private var user : User = User()
    private var context : NSManagedObjectContext
    
    //Método para crear una instancia de tipo Task
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    
    
       
    
    
    
    /*func fetch() -> [User] {
        do {
            self.users = try self.context.fetch(User.fetchRequest())
        }
        catch{
            print("err: ", error)
            return []
        }
        return self.users
    }*/
    func fetch() -> User {
        print("in fetch users")
            do {
                //self.users = try self.context.fetch(User.fetchRequest())
                print("en do")
                self.user = try self.context.fetch(User.fetchRequest())[0]
                
            }
            catch{
                print("EERR: ", error)
                return User()
            }
        
        print(self.user)
            return self.user
        }
    
    func getUser() -> User {
        return self.user
    }
    
    
    
    func saveUser(name:String, email:String, address:String){
        self.user = User(context: self.context)
        self.user.setValue(name, forKey: #keyPath(User.name))
        self.user.setValue(email, forKey: #keyPath(User.email))
        self.user.setValue(address, forKey: #keyPath(User.address))
    }
    
    
    
    
    
    
}




