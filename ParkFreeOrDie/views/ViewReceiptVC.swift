/*****************************************************************
* Project: ParkFreeOrDie
* Programmer: Jeremy Clark
* Programmer: Jayce Merinchuk
* File: ViewReceiptVC.swift
* Desccription: This screen shows the receipt details to the user.
*****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: ViewReceiptVC : UIViewController
 * Description: Displays information about parking receipt for editing.
*****************************************************************/
class ViewReceiptVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var streetNameLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var postalCodeLabel: UITextField!
    @IBOutlet weak var countryLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var hoursParkedLabel: UITextField!
    @IBOutlet weak var costLabel: UITextField!
    
    // Class Variables
    var receipt : Receipt?
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fill boxes with information if available
        streetNameLabel.text = receipt?.street
        cityLabel.text = receipt?.city
        postalCodeLabel.text = receipt?.postal
        countryLabel.text = receipt?.country
        hoursParkedLabel.text = String(receipt!.hoursParked)
        costLabel.text = String(receipt!.cost)
        dateLabel.text = String(receipt!.getDateAsString())
    }
}
