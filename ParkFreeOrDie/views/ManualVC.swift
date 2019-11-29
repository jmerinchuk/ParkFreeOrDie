/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ManualVC.swift
 * Desccription: MAnages the Manual Scene to display the app manual.
 *****************************************************************/

// Imports
import UIKit
import WebKit

/*****************************************************************
 * Class: ManualVC : UIViewController
 * Description: The VC sets up the view for the manual .html page.
*****************************************************************/
class ManualVC : UIViewController, WKUIDelegate {

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
     * Method: loadView()
     * Description: sets up webconfiguration and delegate
    *************************************************************/
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
