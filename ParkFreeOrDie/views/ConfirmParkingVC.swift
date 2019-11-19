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
    var date : String = ""
    var time : String = ""
    var hoursParked : Int = 0
    
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
        setLabels()
        
    }
    
    /*************************************************************
     * Method: setLabels()
     * Description: sets Labels on scene
    *************************************************************/
    func setLabels() {
//        print("ConfirmParking Labels: " + street + " " + city + " " + postal + " " + country)
        lblStreet.text = street
        lblCity.text = city
        lblPostal.text = postal
        lblCountry.text = country
        lblDate.text = date
        lblTime.text = time
        lblHours.text = String(hoursParked)
    }
    
    /*************************************************************
     * Method: getCurrentDateAndTime()
     * Description: Obtians Current Date and Time
    *************************************************************/
    func getCurrentDateAndTime() {
        let newDate = Date()
        let yearmoday = DateFormatter()
        yearmoday.dateFormat = "yyyy-MM-dd"
        let newTime = DateFormatter()
        newTime.dateFormat = "HH:mm:ss"
        date = yearmoday.string(from: newDate)
        time = newTime.string(from: newDate)
    }
    
    
    /*************************************************************
     * Method: btnParkHere()
     * Description: Saves Parking Receipt to Core Data and Pops VC back to parking.
    *************************************************************/
    @IBAction func btnParkHere(_ sender: Any) {
        
        
    }
}

