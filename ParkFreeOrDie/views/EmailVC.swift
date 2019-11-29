/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: EmailVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit
import MessageUI

/*****************************************************************
 * Class: EmailVC : UIViewController
 * Description:
*****************************************************************/
class EmailVC : UIViewController {
    
    // Outlets
    @IBOutlet var txtSubject : UITextField!
    @IBOutlet var txtMessage : UITextField!

    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*************************************************************
     * Method: btnSendEmail()
     * Description: Sends email to
    *************************************************************/
    @IBAction func btnSendEmail(_ sender: Any) {
        print("Trying to send email...")
        
        let subject = String(txtSubject.text ?? "")
        let message = String(txtMessage.text ?? "")
        
        if (subject == "" || message == "") {
            let alertController = UIAlertController(title: "Subject and Message Required", message:
            "Please ensure you've entered a subject line and message", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else {
            if (MFMailComposeViewController.canSendMail()) {
                let emailPicker = MFMailComposeViewController()
                
                emailPicker.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
                emailPicker.setSubject(subject)
                emailPicker.setMessageBody(message, isHTML: true)
                self.present(emailPicker, animated: true, completion: nil)
                
                // Return to previous Screen
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "We're Sorry", message:
                "We ran into an unexpected error and we were unable to send your message.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

/*****************************************************************
 * Extension: ContactDetail : MFMessageComposeViewControllerDelegate
 * Description: Manages Sending the Email
*****************************************************************/
extension EmailVC : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Operations to perform when message composer finishes with results
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

