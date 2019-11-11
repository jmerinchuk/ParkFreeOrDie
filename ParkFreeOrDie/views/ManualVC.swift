/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ManualVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit
import WebKit // Make Web Page to display manual

/*****************************************************************
 * Class: ManualVC : UIViewController
 * Description:
*****************************************************************/
class ManualVC : UIViewController, WKUIDelegate {

    // Class Variables
    
    
    // Outlets
    @IBOutlet var webView : WKWebView!
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = URL (string: "https://www.google.ca");
        let url = Bundle.main.url(forResource: "AppManual", withExtension: ".html")
        let requestObj = URLRequest(url: url!);
        webView.load(requestObj);
    }
        
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
