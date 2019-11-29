/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ParkingVC.swift
 * Desccription: Displays box for number of hours and allows the usre to proceed to map screen.
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: AccountVC : UIViewController
 * Description: Displays the Parking Tab view where user can add number of hours.
*****************************************************************/
class ParkingVC : UIViewController {
    
    // Outlets
    @IBOutlet var txtHours: UITextField!
    @IBOutlet var lblDate: UILabel!
    
    // Class Variables
    var hoursParked : Int = 0
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
    }
    
    /*************************************************************
     * Method: getCurrentDate()
     * Description: Obtians Current Date and Time
    *************************************************************/
    func getCurrentDate() {
        let newDate = Date()
        let yearmoday = DateFormatter()
        yearmoday.dateFormat = "MM-dd-yyyy"
        lblDate.text = "Today is " + yearmoday.string(from: newDate)
    }
    
    /*************************************************************
     * Method: btnFindParking()
     * Description: Checks for a number of hours and proceeds to the next screen.
    *************************************************************/
    @IBAction func btnFindParking(_ sender: Any) {
        hoursParked = Int(txtHours.text!) ?? 0
        
        if (hoursParked > 0) {
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mapVC = mainSB.instantiateViewController(withIdentifier: "MapScene") as! MapVC
            mapVC.hoursParked = self.hoursParked
            navigationController?.pushViewController(mapVC, animated: true)
        } else {
            let alertController = UIAlertController(title: "Hours Required", message:
            "Please Enter how long you will be parking", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
