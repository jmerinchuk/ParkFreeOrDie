/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: User.swift
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
class User {
    
    // Class Variables
    var name: String
    var email: String
    var phoneNumber: String
    var licensePlate: String
    var creditCardNumber : String
    var creditCardName : String
    var creditCardExpiry : String
    var creditCardCVV : String
    var password : String
    
    /*************************************************************
     * Method: init()
     * Description: Initializer for User Object
    *************************************************************/
    init(name: String,
         email: String,
         phoneNumber: String,
         licensePlate: String,
         creditCardNumber: String,
         creditCardName: String,
         creditCardExpiry: String,
         creditCardCVV: String,
         password: String) {
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.licensePlate = licensePlate
        self.creditCardNumber = creditCardNumber
        self.creditCardName = creditCardName
        self.creditCardExpiry = creditCardExpiry
        self.creditCardCVV = creditCardCVV
        self.password = password
    }
}

