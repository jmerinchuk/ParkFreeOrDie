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
    private var textFields: [UITextField] = []
    
    // Outlets
    @IBOutlet weak var errorLabel: UILabel!
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
                errorLabel.text = "Fields cannot be left empty"
            }
        }
        
        //if the user has not left any fields empty, we can begin checking validity...
        if(!invalidData) {
            var user: User = User(  name: nameTextField.text!,
                                    email: emailTextField.text!,
                                    phoneNumber: phoneNumberTextField.text!,
                                    licensePlate: licensePlateTextField.text!,
                                    creditCardNumber: creditCardNumberTextField.text!,
                                    creditCardName: creditCardNameTextField.text!,
                                    creditCardExpiry: creditCardExpiryTextField.text!,
                                    creditCardCVV: creditCardCVVTextField.text!,
                                    password: passwordTextField.text!)
            //checks for same passwords:
            if( (passwordTextField.text!) != (repeatPasswordTextField.text!)) {
                passwordTextField.backgroundColor = errorColor
                repeatPasswordTextField.backgroundColor = errorColor
                invalidData = true
                errorLabel.text = "Passwords do not match"
            }
            
            
            if(user.nameIsValid() != nil){
                invalidData = true
                nameTextField.backgroundColor = errorColor
                errorLabel.text = user.nameIsValid()
            }
            
            if(user.emailIsValid() != nil){
                invalidData = true
                emailTextField.backgroundColor = errorColor
                errorLabel.text = user.emailIsValid()
            }
            
            if(user.phoneNumberIsValid() != nil){
                invalidData = true
                phoneNumberTextField.backgroundColor = errorColor
                errorLabel.text = user.phoneNumberIsValid()
            }
            
            if(user.licensePlateIsValid() != nil){
                invalidData = true
                licensePlateTextField.backgroundColor = errorColor
                errorLabel.text = user.licensePlateIsValid()
            }
            
            if(user.creditCardNumberIsValid() != nil){
                invalidData = true
                creditCardNumberTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardNumberIsValid()
            }
            
            if(user.creditCardNameIsValid() != nil){
                invalidData = true
                creditCardNameTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardNameIsValid()
            }
            
            if(user.creditCardExpiryIsValid() != nil){
                invalidData = true
                creditCardExpiryTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardExpiryIsValid()
            }
            
            if(user.creditCardCVVIsValid() != nil){
                invalidData = true
                creditCardCVVTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardCVVIsValid()
            }
            
            
            //insert into CoreData
            if(invalidData == false) {
                let userController : UserController = UserController()
            
                userController.insertUser(newUser: user)
                
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
        
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
        errorLabel.text = ""
    }
    
}


