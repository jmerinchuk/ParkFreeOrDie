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
    var code : String
    
    /*************************************************************
     * Method: init()
     * Description: Initializer for Receipt Object
    *************************************************************/
    init(hoursParked: Int, code: String) {
        self.hoursParked = hoursParked
        self.code = code
    }
}
