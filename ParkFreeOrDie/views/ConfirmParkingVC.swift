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
    
    // Outlets
    @IBOutlet var lblStreet: UILabel!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblPostal: UILabel!
    @IBOutlet var lblCountry: UILabel!
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    /*************************************************************
     * Method: setLabels()
     * Description: sets Labels on scene
    *************************************************************/
    func setLabels() {
        print("ConfirmParking Labels: " + street + " " + city + " " + postal + " " + country)
        lblStreet.text = street
        lblCity.text = city
        lblPostal.text = postal
        lblCountry.text = country
    }
}

