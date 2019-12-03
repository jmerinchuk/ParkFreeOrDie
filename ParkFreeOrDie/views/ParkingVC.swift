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
class ParkingVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlets
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var hoursPicker: UIPickerView!
    
    // Class Variables
    var hoursParked : Int = 0
    var hoursData : [String] = [String]()
    var hoursAmount : [Int] = [Int]()
    var selectedHours : String! = "1"
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
        self.populatePicker()
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
     * Method: populatePicker()
     * Description: populates picker view with 1-20 hours
    *************************************************************/
    func populatePicker(){
        //initialize array data
        hoursData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
        hoursAmount = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
        
        self.hoursPicker.delegate = self
        self.hoursPicker.dataSource = self
    }
    
    /*************************************************************
     * Method: numberOfComponents() Return Int
     * Description: Shows 1 item in picker view at a time
    *************************************************************/
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*************************************************************
     * Method: pickerView() Return Int
     * Description: Returns number of items in Picker View
    *************************************************************/
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.hoursData.count
    }
    
    /*************************************************************
     * Method: pickerView() Return String
     * Description: Returns a string for each item in picker view
    *************************************************************/
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.hoursData[row]
    }
    
    /*************************************************************
     * Method: pickerView()
     * Description: Fetch item from picker
    *************************************************************/
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedHours = self.hoursData[row]
        
        self.hoursParked = self.hoursAmount[row]
    }
    
    
    
    /*************************************************************
     * Method: btnFindParking()
     * Description: Checks for a number of hours and proceeds to the next screen.
    *************************************************************/
    @IBAction func btnFindParking(_ sender: Any) {
//        print("Hours are: " + String(hoursParked))
        
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
