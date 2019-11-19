/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ParkingVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: AccountVC : UIViewController
 * Description:
*****************************************************************/
class ParkingVC : UIViewController {

    // Class Variables
    var hoursParked : Int = 0
    
    // Outlets
    @IBOutlet var txtHours: UITextField!
    @IBOutlet var lblDate: UILabel!
    
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
     * Description:
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
