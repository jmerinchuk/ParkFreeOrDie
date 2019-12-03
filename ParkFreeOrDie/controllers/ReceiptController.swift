/*****************************************************************
* Project: ParkFreeOrDie
* Programmer: Jeremy Clark
* Programmer: Jayce Merinchuk
* File: ReceiptController.swift
* Desccription: Manages Receipts in Database
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
     * Method: receiptFromNSManagedObject()
     * Description: Returns a Receipt object given an NSManagedObject object.
    *************************************************************/
    static func receiptFromNSManagedObject(obj: NSManagedObject) -> Receipt{
        let street = (obj.value(forKey: "street") as? String)!
        let city = obj.value(forKey: "city") as? String
        let postal = obj.value(forKey: "postal") as? String
        let country = obj.value(forKey: "country") as? String
        let licensePlate = obj.value(forKey: "licensePlate") as? String
        let date = obj.value(forKey: "date") as? Date
        let hoursParked = obj.value(forKey: "hoursParked") as? Int
        let cost = obj.value(forKey: "cost") as? Int
        
        return Receipt(hoursParked: hoursParked!, street: street, city: city!, postal: postal!, country: country!, licensePlate: licensePlate!, date: date!, cost: cost!)
        
    }
    /*************************************************************
     * Method: calculateCost()
     * Description: returns the price based on how many hours parked, and how many times you have parked this month.
    *************************************************************/
    static func getCost(hours: Int, date: Date) -> Int {
        let numberOfReceiptsThisMonth = self.getNumberOfReceiptsForMonth(date: date)
        
        if(numberOfReceiptsThisMonth < 3){
            return 0
        }
        
        if(hours <= 1){
            return 4
        }else if(hours <= 3){
            return 8
        }else if(hours <= 10){
            return 12
        }
        return 20
    }
    
    /*************************************************************
     * Method: getNumberOfReceiptsForMonth()
     * Description: Returns the number of receipts stored for this month/year
    *************************************************************/
    static func getNumberOfReceiptsForMonth(date: Date) -> Int {
        let calendar = Calendar.current
        let year : Int = calendar.component(.year, from: date)
        let month : Int = calendar.component(.month, from: date)
        var count : Int = 0
        
        let receipts = ReceiptController.getAllReceipts()
        for receipt in receipts!{
            let receiptDate :Date = (receipt.value(forKey: "Date") as? Date)!
            if( calendar.component(.year, from: receiptDate) == year &&
                calendar.component(.month, from: receiptDate) == month ) {
                count += 1
            }
        }
        return count
    }
    
    /*************************************************************
     * Method: createReceipt()
     * Description: Inserts new receipt into database
    *************************************************************/
    static func createReceipt(hoursParked: Int, street: String, city: String, postal: String, country: String, licensePlate: String, date: Date, cost: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let receiptEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ReceiptEntity", in: managedContext)
        
        // If we have access to Receipt Table
        if (receiptEntity != nil) {
            let newreceipt = NSManagedObject(entity: receiptEntity!, insertInto: managedContext)
            
            newreceipt.setValue(hoursParked, forKey: "hoursParked")
            newreceipt.setValue(street, forKey: "street")
            newreceipt.setValue(city, forKey: "city")
            newreceipt.setValue(postal, forKey: "postal")
            newreceipt.setValue(country, forKey: "country")
            newreceipt.setValue(licensePlate, forKey: "licensePlate")
            newreceipt.setValue(date, forKey: "date")
            newreceipt.setValue(cost, forKey: "cost")
            
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
    static func updateReceipt(receipt: Receipt, oldTitle: String){
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
    static func deleteReceipt(receipt: Receipt){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReceiptEntity")
        fetchRequest.predicate = NSPredicate(format: "date = %@", receipt.date as NSDate)
        
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
    static func getAllReceipts() -> [NSManagedObject]?  {
        
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

