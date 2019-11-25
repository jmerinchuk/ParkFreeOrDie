/*****************************************************************
* Project: ParkFreeOrDie
* Programmer: Jeremy Clark
* Programmer: Jayce Merinchuk
* File: ReceiptController.swift
* Desccription:
*
* Sources:
*
*****************************************************************/

// Imports
import Foundation
import UIKit
import CoreData

/*****************************************************************
 * Class: ReceiptController
 * Description: Manages functions involving the Receipt Entity.
*****************************************************************/
public class ReceiptController {
    
    /*************************************************************
     * Method: insertReceipt()
     * Description: Inserts new receipt into database
    *************************************************************/
    func insertReceipt(newReceipt: Receipt){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let receiptEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ReceiptEntity", in: managedContext)
        
        // If we have access to Receipt Table
        if (receiptEntity != nil) {
            let newreceipt = NSManagedObject(entity: receiptEntity!, insertInto: managedContext)
            
            newreceipt.setValue(newReceipt.hoursParked, forKey: "hoursParked")
            newreceipt.setValue(newReceipt.street, forKey: "street")
            newreceipt.setValue(newReceipt.city, forKey: "city")
            newreceipt.setValue(newReceipt.postal, forKey: "postal")
            newreceipt.setValue(newReceipt.country, forKey: "country")
            newreceipt.setValue(newReceipt.licensePlate, forKey: "licensePlate")
            newreceipt.setValue(newReceipt.date, forKey: "date")
            
            // Attempt to save data and provide error if it failed
            do {
                try managedContext.save()
                print("Successfully saved new receipt.")
            } catch let error as NSError {
                print("Insert receipt has failed. \(error), \(error.userInfo)")
            }
        }
    }
    
    /******************************************************************
     * Method: updateReceipt(Receipt)
     * Description: Updates  receipt in the table
     *****************************************************************/
    func updateReceipt(receipt: Receipt, oldTitle: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReceiptEntity")
        fetchRequest.predicate = NSPredicate(format: "title = %@", oldTitle)
        
        // Attempt to fetch the existing Receipt
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            let existingReceipt = result[0] as! NSManagedObject
            existingReceipt.setValue(receipt.hoursParked, forKey: "hoursParked")
            existingReceipt.setValue(receipt.street, forKey: "street")
            existingReceipt.setValue(receipt.city, forKey: "city")
            existingReceipt.setValue(receipt.postal, forKey: "postal")
            existingReceipt.setValue(receipt.country, forKey: "country")
            existingReceipt.setValue(receipt.licensePlate, forKey: "licensePlate")
            existingReceipt.setValue(receipt.date, forKey: "date")
            
            // Attempt to save the existing receipt with new data
            do {
                try managedContext.save()
                print("Successfully saved update to existing receipt.")
            } catch {
                print("Failed to save existing receipt.")
            }
        } catch {
            print("Failed to fetch existing receipt.")
        }
    }
    
    /******************************************************************
     * Method: deleteReceipt(Receipt)
     * Description:  Removes existing receipt data
     *****************************************************************/
    func deleteReceipt(title: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReceiptEntity")
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        // Attempt to fetch the existing Receipt
        do {
            let result = try managedContext.fetch(fetchRequest)
            let existingReceipt = result[0] as! NSManagedObject
            managedContext.delete(existingReceipt)
            
            // Attempt to save the table after deleting receipt
            do {
                try managedContext.save()
                print("Successfully deleted receipt.")
            } catch {
                print("Failed to delete receipt.")
            }
        } catch {
            print("Failed to fetch existing receipt.")
        }
    }
    
    /******************************************************************
     * Method: getAllReceipts() return NSmanagedObject
     * Description: returns all Receipts
     *****************************************************************/
    func getAllReceipts() -> [NSManagedObject]?  {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReceiptEntity")
        
        // Use fetch request and return Managed Object
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            print("Failed to fetch data.")
        }
        return nil
    }
}

