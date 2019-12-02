/*****************************************************************
* Project: ParkFreeOrDie
* Programmer: Jeremy Clark
* Programmer: Jayce Merinchuk
* File: UserController.swift
* Desccription: Manages users in Database.
*****************************************************************/

// Imports
import Foundation
import UIKit
import CoreData

/*****************************************************************
 * Class: UserController
 * Description: Functions for managing Users.
*****************************************************************/
public class UserController {
    
    // Class Variables
    static var loggedInUser : User?
    
    /*************************************************************
     * Method: getLoggedInUser() Return User?
     * Description: Gets current user that is logged in.
    *************************************************************/
    static func getLoggedInUser() -> User? {
        return UserController.loggedInUser ?? nil
    }
    
    /*************************************************************
     * Method: setLoggedInUser(user)
     * Description: Sets current user that is logged in.
    *************************************************************/
    static func setLoggedInUser(user: User?) {
        UserController.loggedInUser = user
    }
    
    /*************************************************************
     * Method: getUserPlate() Return String
     * Description: Returns user plate number
    *************************************************************/
    static func getUserPlate() -> String {
        return ""
    }
    
    /*************************************************************
     * Method: insertUser(user)
     * Description: Inserts new user into database
    *************************************************************/
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
    
    /*************************************************************
     * Method: updateUser(user)
     * Description: Updates user in database
    *************************************************************/
    func updateUser(user: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.email)
        do{
            let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if result!.count != 0{

                let managedObject = result![0]
                managedObject.setValue(user.name, forKey: "name")
                managedObject.setValue(user.phoneNumber, forKey: "phoneNumber")
                managedObject.setValue(user.licensePlate, forKey: "licensePlate")
                managedObject.setValue(user.creditCardNumber, forKey: "creditCardNumber")
                managedObject.setValue(user.creditCardName, forKey: "creditCardName")
                managedObject.setValue(user.creditCardExpiry, forKey: "creditCardExpiry")
                managedObject.setValue(user.creditCardCVV, forKey: "creditCardCVV")
                managedObject.setValue(user.password, forKey: "password")
                try managedContext.save()
            }
        }catch let error as NSError {
            print("Updating user failed: \(error), \(error.userInfo)")
        }
    }
    
    /*************************************************************
     * Method: getUserByEmail(email) Return User?
     * Description: Gets a user from the database
    *************************************************************/
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
    
    /*************************************************************
     * Method: getAllUSers() Return NSManagedObject Array
     * Description: Gets all users in the system.
    *************************************************************/
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
