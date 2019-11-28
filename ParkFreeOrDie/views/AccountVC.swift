/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: AccountVC.swift
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
class AccountVC : UIViewController {

    // Class Variables
    private var textFields: [UITextField] = []
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardExpiryDateTextField: UITextField!
    @IBOutlet weak var cardCVVTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRepeatTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [nameTextField, emailTextField, phoneTextField, licensePlateTextField,
                      cardNumberTextField, cardNameTextField, cardExpiryDateTextField, cardCVVTextField,
                      passwordTextField, passwordRepeatTextField]
        
        //gives each textField a function that returns it to its original color when typed into.
        for field in textFields {
            field.addTarget(self, action: #selector(restoreOriginalColor(sender:)), for: .editingChanged)
        }
    }
    @IBAction func onLogoutButtonPress(_ sender: Any) {
        UserController.setLoggedInUser(user: nil)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! UIViewController
        let customViewControllersArray : NSArray = [tabBarVC]
        self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onSaveChangesButtonPress(_ sender: Any) {
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
            let user: User = User(  name: nameTextField.text!,
                                    email: emailTextField.text!,
                                    phoneNumber: phoneTextField.text!,
                                    licensePlate: licensePlateTextField.text!,
                                    creditCardNumber: cardNumberTextField.text!,
                                    creditCardName: cardNameTextField.text!,
                                    creditCardExpiry: cardExpiryDateTextField.text!,
                                    creditCardCVV: cardCVVTextField.text!,
                                    password: passwordTextField.text!)
            //checks for same passwords:
            if( (passwordTextField.text!) != (passwordRepeatTextField.text!)) {
                passwordTextField.backgroundColor = errorColor
                passwordRepeatTextField.backgroundColor = errorColor
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
                phoneTextField.backgroundColor = errorColor
                errorLabel.text = user.phoneNumberIsValid()
            }
            
            if(user.licensePlateIsValid() != nil){
                invalidData = true
                licensePlateTextField.backgroundColor = errorColor
                errorLabel.text = user.licensePlateIsValid()
            }
            
            if(user.creditCardNumberIsValid() != nil){
                invalidData = true
                cardNumberTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardNumberIsValid()
            }
            
            if(user.creditCardNameIsValid() != nil){
                invalidData = true
                cardNameTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardNameIsValid()
            }
            
            if(user.creditCardExpiryIsValid() != nil){
                invalidData = true
                cardExpiryDateTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardExpiryIsValid()
            }
            
            if(user.creditCardCVVIsValid() != nil){
                invalidData = true
                cardCVVTextField.backgroundColor = errorColor
                errorLabel.text = user.creditCardCVVIsValid()
            }
            
            
            //insert into CoreData
            if(invalidData == false) {
                let userController : UserController = UserController()
            
                userController.updateUser(user: user)
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                let customViewControllersArray : NSArray = [tabBarVC]
                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
    
    /*************************************************************
     * Method: viewDidAppear()
     * Description: Called when the view is shown to the user.
    *************************************************************/
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.text = UserController.getLoggedInUser()!.name
        emailTextField.text = UserController.getLoggedInUser()!.email
        phoneTextField.text = UserController.getLoggedInUser()!.phoneNumber
        licensePlateTextField.text = UserController.getLoggedInUser()!.licensePlate
        cardNameTextField.text = UserController.getLoggedInUser()!.creditCardName
        cardNumberTextField.text = UserController.getLoggedInUser()!.creditCardNumber
        cardExpiryDateTextField.text = UserController.getLoggedInUser()!.creditCardExpiry
        cardCVVTextField.text = UserController.getLoggedInUser()!.creditCardCVV
        
        errorLabel.text = ""
    }
    
    @objc func restoreOriginalColor(sender: UITextField) {
        sender.backgroundColor = UIColor.white
        errorLabel.text = ""
    }
}


