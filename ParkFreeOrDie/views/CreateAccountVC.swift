/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: CreateAccountVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: CreateAccountVC : UIViewController
 * Description:
*****************************************************************/
class CreateAccountVC : UIViewController {

    // Class Variables
    
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var creditCardNameTextField: UITextField!
    @IBOutlet weak var creditCardExpiryTextField: UITextField!
    @IBOutlet weak var creditCardCVVTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    private var textFields: [UITextField] = []
    
    
    @IBAction func onCreateAccountButtonTouchUpInside(_ sender: Any) {
        //check all fields for valid info.
        //if one fails, color it red.
        var invalidData = false
        let errorColor: UIColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
        
        //checks for empty fields...
        for field in textFields {
            if((field.text ?? "").isEmpty) {
                invalidData = true
                field.backgroundColor = errorColor
            }
        }
        
        //checks for same passwords:
        if( (passwordTextField.text!) != (repeatPasswordTextField.text!)) {
            passwordTextField.backgroundColor = errorColor
            repeatPasswordTextField.backgroundColor = errorColor
            invalidData = true
        }
        
        //insert into CoreData
        if(invalidData == false) {
            let userController : UserController = UserController()
        
            userController.insertUser(newUser: User(name: nameTextField.text!,
                                                    email: emailTextField.text!,
                                                    phoneNumber: phoneNumberTextField.text!,
                                                    licensePlate: licensePlateTextField.text!,
                                                    creditCardNumber: creditCardNumberTextField.text!,
                                                    creditCardName: creditCardNameTextField.text!,
                                                    creditCardExpiry: creditCardExpiryTextField.text!,
                                                    creditCardCVV: creditCardCVVTextField.text!,
                                                    password: passwordTextField.text!))
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields = [nameTextField, emailTextField, phoneNumberTextField, licensePlateTextField,
                      creditCardNumberTextField, creditCardNameTextField, creditCardExpiryTextField, creditCardCVVTextField,
                      passwordTextField, repeatPasswordTextField]
        
        //gives each textField a function that returns it to its original color when typed into.
        for field in textFields {
            field.addTarget(self, action: #selector(restoreOriginalColor(sender:)), for: .editingChanged)
        }
    }
    
    @objc func restoreOriginalColor(sender: UITextField) {
        sender.backgroundColor = UIColor.white
    }
    
}


