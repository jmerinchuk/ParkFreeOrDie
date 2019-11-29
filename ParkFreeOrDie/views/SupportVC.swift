/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: SupportVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit
import CallKit
import MessageUI

/*****************************************************************
 * Class: SupportVC : UIViewController
 * Description:
*****************************************************************/
class SupportVC : UIViewController {

    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*************************************************************
     * Method: btnCall()
     * Description: Support button for call - opens phone app
    *************************************************************/
    @IBAction func btnCall(_ sender: Any) {
        print("Trying to call...")
        let phoneNumber : String = "905-541-8718"
        let callString : String = "tel://\(phoneNumber)"
        
        let url = URL(string: callString)
        print("URL : \(url)")
        
        // check if app is available to execute the created URL
        if UIApplication.shared.canOpenURL(url!) {
            // Check version of iOS on device
            if #available(iOS 10, *) {
            // if app is available, open URL
                UIApplication.shared.open(url!)
            } else {
                UIApplication.shared.openURL(url!)
            }
        } else {
            print("Can't place call")
        }
    }
}

/*****************************************************************
 * Extension: ContactDetail : MFMessageComposeViewControllerDelegate
 * Description: Manages Opening the Phone Application
*****************************************************************/
extension SupportVC : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Operations to perform when message composer finishes with results
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
