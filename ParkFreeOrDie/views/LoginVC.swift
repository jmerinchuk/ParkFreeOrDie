/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: LoginVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: LoginVC : UIViewController
 * Description:
*****************************************************************/
class LoginVC : UIViewController {

    // Class Variables
    
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputErrorLabel: UILabel!
    
    @IBAction func onLoginButtonTouchUpInside(_ sender: Any) {
        let errorColor: UIColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
        var inputError: Bool = false
        let userController = UserController()
        let user:User?
        
        if( (emailTextField.text ?? "").isEmpty){
            emailTextField.backgroundColor = errorColor
            inputError = true
        }
        
        if( (passwordTextField.text ?? "").isEmpty) {
            passwordTextField.backgroundColor = errorColor
            inputError = true
        }
         
        if(!inputError){
            user = userController.getUserByEmail(email: emailTextField.text!)
            if(user == nil) {
                //show "USer not found with this email" on the screen.
                inputErrorLabel.text = "User with this email could not be found"
                emailTextField.backgroundColor = errorColor
                return
            }
            
            if(user?.email == emailTextField.text && user?.password == passwordTextField.text){
                //succesful login!
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                navigationController?.pushViewController(tabBarVC, animated: true)
            }else{
                //invalid username/password.
                inputErrorLabel.text = "Password incorrect"
                passwordTextField.backgroundColor = errorColor
            }
        }else{
            inputErrorLabel.text = "Fields cannot be empty"
        }
    }
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded function for the View
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(restoreOriginalColor(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(restoreOriginalColor(sender:)), for: .editingChanged)
    }
    
    @objc func restoreOriginalColor(sender: UITextField) {
        sender.backgroundColor = UIColor.white
        inputErrorLabel.text = ""
    }
}

