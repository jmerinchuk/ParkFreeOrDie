//
//  UserController.swift
//  ParkFreeOrDie
//
//  Created by jermey on 2019-11-11.
//  Copyright © 2019 MerinClark Ltd. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class UserController {
    func insertUser(newUser: User){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext)
        
        if (userEntity != nil) {
            let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            
            user.setValue(newUser.name, forKey: "name")
            user.setValue(newUser.email, forKey: "email")
            user.setValue(newUser.phoneNumber, forKey: "phoneNumber")
            user.setValue(newUser.licensePlate, forKey: "licensePlate")
            user.setValue(newUser.creditCardNumber, forKey: "creditCardNumber")
            user.setValue(newUser.creditCardName, forKey: "creditCardName")
            user.setValue(newUser.creditCardExpiry, forKey: "creditCardExpiry")
            user.setValue(newUser.creditCardCVV, forKey: "creditCardCVV")
            user.setValue(newUser.password, forKey: "password")
            
            do {
                try managedContext.save()
                print("Successfully saved new User")
            } catch let error as NSError {
                print("Saving user failed: \(error), \(error.userInfo)")
            }
        }
    }
    
    func getUserByEmail(email: String) -> User? {
        let allUsers = getAllUsers()
        if(allUsers == nil) {
            return nil
        }
        for user in allUsers! {
            if user.value(forKey: "email") as! String == email {
                
                return User(name: user.value(forKey: "name") as! String,
                            email: user.value(forKey: "email") as! String,
                            phoneNumber: user.value(forKey: "phoneNumber") as! String,
                            licensePlate: user.value(forKey: "licensePlate") as! String,
                            creditCardNumber: user.value(forKey: "creditCardNumber") as! String,
                            creditCardName: user.value(forKey: "creditCardName") as! String,
                            creditCardExpiry: user.value(forKey: "creditCardExpiry") as! String,
                            creditCardCVV: user.value(forKey: "creditCardCVV") as! String,
                            password: user.value(forKey: "password") as! String)
            }
        }
        return nil
    }
    
    func getAllUsers() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            print("Failed to get users")
        }
        return nil
    }
}
