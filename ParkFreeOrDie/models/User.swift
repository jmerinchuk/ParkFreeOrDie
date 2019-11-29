/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: User.swift
 * Desccription: Creates a user object with details
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
    
    /*************************************************************
     * Method: creditCardExpiryAsDate()
     * Description: Initializer for User Object
    *************************************************************/
    func creditCardExpiryAsDate() -> Date? {
        //let dateArray = self.creditCardExpiry.split{$0 == "/"}.map(String.init)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        let someDateTime = formatter.date(from: self.creditCardExpiry)
        return someDateTime
    }
    
    /*************************************************************
     * Method: nameIsValid() Return String?
     * Description: Validates user name
    *************************************************************/
    func nameIsValid() -> String? {
        if(self.name.count < 3) {
            return "Name must be at least 3 characters long"
        }
        return nil
    }
    
    /*************************************************************
     * Method: emailIsValid() Return String?
     * Description: Validates emails
    *************************************************************/
    func emailIsValid() -> String? {
        if(!self.email.contains("@") || !self.email.contains(".")) {
            return "Email must contain a '@' and a '.'"
        }
        return nil
    }
    
    /*************************************************************
     * Method: phoneNumberIsValid() Return String?
     * Description: Validates user phone number
    *************************************************************/
    func phoneNumberIsValid() -> String? {
        
        if(Set(self.phoneNumber).isSubset(of: Set("0123456789-")) == false) {
            return "Invalid characters in Phone Number"
        }
        return nil
    }
    
    /*************************************************************
     * Method: licensePlateIsValid() return String?
     * Description: Validates user license plate number
    *************************************************************/
    func licensePlateIsValid() -> String? {
        if(self.licensePlate.count < 5) {
            return "License plate must be at least 5 characters"
        }
        return nil
    }
    
    /*************************************************************
     * Method: creditCardNumberIsValid() Return String?
     * Description: Validates Credit Card Number
    *************************************************************/
    func creditCardNumberIsValid() -> String? {
        if(self.creditCardNumber.count < 10){
            return "Credit Card Number is too short"
        }
        if(Set(self.creditCardNumber).isSubset(of: Set("0123456789")) == false){
            return "Invalid characters in Credit Card Number"
        }
        return nil
    }
    
    /*************************************************************
     * Method: creditCardNameIsValid() Return String?
     * Description: Validates Credit Card Name
    *************************************************************/
    func creditCardNameIsValid() -> String? {
        if(self.creditCardName.count < 3){
            return "Credit Card Name must be at least 3 characters"
        }
        return nil
    }
    
    /*************************************************************
     * Method: creditCardExpiryIsValid() Return String?
     * Description: Validates Credit Card Expiry date.
    *************************************************************/
    func creditCardExpiryIsValid() -> String? {
        if(self.creditCardExpiry.count > 7){
            return "Expiry Date too long. (ie. '01/2021')"
        }
        if(self.creditCardExpiry.count < 4){
            return "Expiry date too short. (ie. 01/2021')"
        }
        if(!self.creditCardExpiry.contains("/")) {
            return "Invalid expiry date format. Must contain '/' (ie. 01/2021')"
        }
        if(self.creditCardExpiryAsDate() == nil){
            return "Invalid expiry date format (ie. 01/2021')"
        }
        
        return nil
    }
    
    /*************************************************************
     * Method: creditCardCVVIsValid() Return String?
     * Description: Validates CVV number
    *************************************************************/
    func creditCardCVVIsValid() -> String? {
        if(Set(self.creditCardCVV).isSubset(of: Set("0123456789")) == false){
            return "CVV must only contain numbers"
        }
        if(self.creditCardCVV.count != 3){
            return "CVV must be exactly 3 characters long"
        }
        return nil
    }
    
    /*************************************************************
     * Method: passwordIsValid() Return String?
     * Description: Validates Password Boxes
    *************************************************************/
    func passwordIsValid() -> String? {
        if(self.password.count < 5){
            return "Password must be at least 5 characters long"
        }
        return nil
    }
}

