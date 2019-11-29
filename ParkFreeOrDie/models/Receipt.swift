/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: Receipt.swift
 * Desccription: Creates a receipt object with details.
 *****************************************************************/

// Imports
import Foundation

/*****************************************************************
 * Class: Receipt
 * Description: Receipt Object
*****************************************************************/
class Receipt {
    
    // Class Variables
    var hoursParked : Int
    var street : String
    var city : String
    var postal : String
    var country : String
    var licensePlate : String
    var date : Date
    var cost : Int
    
    /*************************************************************
     * Method: init()
     * Description: Initializer for Receipt Object
    *************************************************************/
    init(hoursParked: Int, street: String, city : String, postal : String, country : String, licensePlate : String, date: Date, cost: Int) {
        self.hoursParked = hoursParked
        self.street = street
        self.city = city
        self.postal = postal
        self.country = country
        self.licensePlate = licensePlate
        self.date = date
        self.cost = cost
    }
    
    /*************************************************************
     * Method: getDateAsString() Return String
     * Description: Returns date as a string.
    *************************************************************/
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self.date)
    }
}
