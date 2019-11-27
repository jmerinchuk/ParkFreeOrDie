/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ConfirmParkingVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: ParkingVC : UIViewController
 * Description:
*****************************************************************/
class ConfirmParkingVC : UIViewController {

    // Class Variables
    var street : String = ""
    var city : String = ""
    var postal : String = ""
    var country : String = ""
    var date : Date = Date()
    var dateString : String = ""
    var time : String = ""
    var hoursParked : Int = 0
    var licensePlate : String = ""
    var cost : Int = 0
    
    // Outlets
    @IBOutlet var lblStreet: UILabel!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblPostal: UILabel!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTimesParked: UILabel!
    @IBOutlet var lblRate: UILabel!
    @IBOutlet var lblCost: UILabel!
    @IBOutlet var lblHours: UILabel!
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDateAndTime()
        
        lblStreet.text = street
        lblCity.text = city
        lblPostal.text = postal
        lblCountry.text = country
        lblDate.text = dateString
        lblTime.text = time
        lblHours.text = String(hoursParked)
        lblCost.text = String(cost)
    }
    
    /*************************************************************
     * Method: getCurrentDateAndTime()
     * Description: Obtians Current Date and Time
    *************************************************************/
    func getCurrentDateAndTime() {
        let date = Date()
        let yearmoday = DateFormatter()
        yearmoday.dateFormat = "yyyy-MM-dd"
        let newTime = DateFormatter()
        newTime.dateFormat = "HH:mm:ss"
        dateString = yearmoday.string(from: date)
        time = newTime.string(from: date)
    }
    
    
    /*************************************************************
     * Method: btnParkHere()
     * Description: Saves Parking Receipt to Core Data and Pops VC back to parking.
    *************************************************************/
    @IBAction func btnParkHere(_ sender: Any) {
        // Get LicensePlate from User
        
        // Pass Receipt to Receipt Controller
        ReceiptController.createReceipt(hoursParked: hoursParked, street: street, city: city, postal: postal, country: country, licensePlate: licensePlate, date: date)
        
        // Manage Alert Box
       let alertController = UIAlertController(title: "Success!", message: "This is the parking you are looking for", preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
       })
       alertController.addAction(okAction)
       present(alertController, animated: true)
    }
}

