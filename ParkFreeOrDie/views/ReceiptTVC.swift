/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ReceiptTVC.swift
 * Desccription:
 *
 * Sources:
 *
 *****************************************************************/

// Imports
import UIKit
import Foundation
import CoreData

/*****************************************************************
 * Class: ReceiptTVC : UITableViewController
 * Description:
*****************************************************************/
class ReceiptTVC: UITableViewController {
    
    // Class Variables
    let receiptController = ReceiptController()

    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLongPressGesture()
    }
    
    /******************************************************************
     * Method: setupLongPressGesture()
     * Description: sets up long press gesture
     *****************************************************************/
    private func setupLongPressGesture() {
        let lpGesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        
        lpGesture.minimumPressDuration = 1.0
        self.tableView.addGestureRecognizer(lpGesture) // attach to entire table view
    }
    
    /******************************************************************
     * Method: setupLongPressGesture()
     * Description: handles the long press gesture.
     *****************************************************************/
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .ended {
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
//                self.displayEditReceipt(indexPath : indexPath)
            }
        }
    }
    
    /*************************************************************
     * Method: numberOfSections()
     * Description: Returns number of sections (1)
    *************************************************************/
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /*************************************************************
     * Method:  tableView(numberOfRowsInSection)
     * Description: Returns number of receipts in table
    *************************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptController.getAllReceipts()!.count
    }

    /******************************************************************
     * Method: tableView() -> TableViewCell
     * Description: returns the cell for each receipt created.
     *****************************************************************/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_receipt", for: indexPath) as! ReceiptCell
        if indexPath.row < receiptController.getAllReceipts()!.count {
            
            let receipt = receiptController.getAllReceipts()![indexPath.row]
            cell.lblTitle?.text = receipt.value(forKeyPath: "hoursParked") as? String
            cell.lblSubtitle?.text = receipt.value(forKeyPath: "code") as? String
        }
        return cell
    }
    
    /******************************************************************
     * Method: tableView()
     * Description: can edit rows
     *****************************************************************/
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /******************************************************************
     * Method: tableView()
     * Description: will delete a receipt when the gesture is used.
     *****************************************************************/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < receiptController.getAllReceipts()!.count {
            self.deleteReceipt(indexPath: indexPath)
            tableView.reloadData()
        }
    }
    
    /******************************************************************
     * Method: addReceipt(indexPath)
     * Description: Adds a new receipt to ReceiptEntity Table
     *****************************************************************/
    private func addReceipt(hoursParked: Int, code: String) {
        let newIndex = receiptController.getAllReceipts()!.count
        let receipt = Receipt(hoursParked: hoursParked, code: code)
        self.receiptController.insertReceipt(newReceipt: receipt)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    /******************************************************************
     * Method: editReceipt(indexPath)
     * Description: passes receipt to controller and edits receipt.
     *****************************************************************/
    private func editReceipt(oldTitle: String, hoursParked: Int, code: String) {
        let receipt = Receipt(hoursParked: hoursParked, code: code)
        self.receiptController.updateReceipt(receipt: receipt, oldTitle: oldTitle)
        tableView.reloadData()
    }
    
    /******************************************************************
     * Method: deleteReceipt(indexPath)
     * Description: Deletes a specific index number passed to it.
     *****************************************************************/
    private func deleteReceipt(indexPath: IndexPath) {
        let receipt = receiptController.getAllReceipts()![indexPath.row]
        let title = receipt.value(forKeyPath: "title") as! String
        receiptController.deleteReceipt(title: title)
        tableView.reloadData()
    }
    
    /******************************************************************
     * Method: displayEditReceipt(indexPath)
     * Description: Displays Alert Box for editing Receipt
     *****************************************************************/
    private func displayEditReceipt(indexPath: IndexPath) {
        
        let addAlert = UIAlertController(title: "Edit Receipt", message: "Edit Receipt Details", preferredStyle: .alert)
        
        let receipt = receiptController.getAllReceipts()![indexPath.row]
        var oldTitle : String?
        
        addAlert.addTextField{(textField : UITextField) in
            oldTitle = receipt.value(forKeyPath: "hoursParked") as? String
            textField.text = receipt.value(forKeyPath: "hoursParked") as? String
            textField.keyboardType = .default
            textField.keyboardAppearance = .dark
            textField.autocorrectionType = .default
        }
        
        addAlert.addTextField{(textField : UITextField) in
            textField.text = receipt.value(forKeyPath: "code") as? String
            textField.keyboardType = .default
            textField.keyboardAppearance = .dark
            textField.autocorrectionType = .default
        }
        
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        addAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            if let hoursParked = addAlert.textFields?[0].text,
                let intHours = Int(hoursParked),
                let code = addAlert.textFields?[1].text {
                self.editReceipt(oldTitle: oldTitle!, hoursParked: intHours, code: code)
            }
        }))
        self.present(addAlert, animated: true, completion: nil)
    }
    
}

