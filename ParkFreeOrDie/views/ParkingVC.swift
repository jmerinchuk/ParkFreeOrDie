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
 * Class: ParkingVC : UIViewController
 * Description:
*****************************************************************/
class ParkingVC : UIViewController {

    // Class Variables
    
    // Outlets
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*************************************************************
     * Method: findParking
     * Description: Pushes view Controller to get parking address details
    *************************************************************/
    @IBAction func findParking(_ sender: Any) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = mainSB.instantiateViewController(withIdentifier: "MapScene") as! MapVC
        navigationController?.pushViewController(mapVC, animated: true)
    }
}
