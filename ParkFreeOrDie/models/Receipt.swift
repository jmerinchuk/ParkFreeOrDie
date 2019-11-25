/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: Receipt.swift
 * Desccription:
 *
 * Sources:
 *
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
    
    
    /*************************************************************
     * Method: init()
     * Description: Initializer for Receipt Object
    *************************************************************/
    init(hoursParked: Int, street: String, city : String, postal : String, country : String, licensePlate : String, date: Date) {
        self.hoursParked = hoursParked
        self.street = street
        self.city = city
        self.postal = postal
        self.country = country
        self.licensePlate = licensePlate
        self.date = date
    }
}
