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
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for long press, use the class UILongPressGestureRecognizer
        //and use:
        //pressGesture.minimumPressDuration = 1.0
        //dont forget to have the press handler class accept a UILongPressGestureRecognizer parameter.
        let pressGesture : UITapGestureRecognizer = UITapGestureRecognizer(target : self, action: #selector(self.handleReceiptPress))
        self.tableView.addGestureRecognizer(pressGesture)
    }

    /*************************************************************
     * Method: viewDidAppear()
     * Description: Called when the view is shown to the user.
    *************************************************************/
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    /******************************************************************
     * Method: setupLongPressGesture()
     * Description: handles the press gesture.
     *****************************************************************/
    @objc func handleReceiptPress(_ gestureRecognizer: UITapGestureRecognizer){
        if gestureRecognizer.state == .ended {
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                self.displayEditReceipt(indexPath : indexPath)
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
        return ReceiptController.getAllReceipts()!.count
    }

    /******************************************************************
     * Method: tableView() -> TableViewCell
     * Description: returns the cell for each receipt created.
     *****************************************************************/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_receipt", for: indexPath) as! ReceiptCell
        if indexPath.row < ReceiptController.getAllReceipts()!.count {
            let receipt = ReceiptController.receiptFromNSManagedObject(obj: ReceiptController.getAllReceipts()![indexPath.row])
            
            cell.lblTitle?.text = receipt.street
            
            cell.lblTotal?.text = "$ \(receipt.cost)"

            cell.lblSubtitle?.text = receipt.getDateAsString()
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
        
        if indexPath.row < ReceiptController.getAllReceipts()!.count {
            self.deleteReceipt(indexPath: indexPath)
            tableView.reloadData()
        }
    }
    
    /******************************************************************
     * Method: addReceipt(indexPath)
     * Description: Adds a new receipt to ReceiptEntity Table
     *****************************************************************/
    private func addReceipt(hoursParked: Int, street: String, city: String, postal: String, country: String, licensePlate: String, date: Date) {
        let newIndex = ReceiptController.getAllReceipts()!.count
        ReceiptController.createReceipt(hoursParked: hoursParked, street: street, city: city, postal: postal, country: country, licensePlate: licensePlate, date: date)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    /******************************************************************
     * Method: editReceipt(indexPath)
     * Description: passes receipt to controller and edits receipt.
     *****************************************************************/
    private func editReceipt(oldTitle: String, hoursParked: Int, street: String, city: String, postal: String, country: String, licensePlate: String, date: Date) {
        //let receipt = Receipt(hoursParked: hoursParked, street: street, city: city, postal: postal, country: country, licensePlate: licensePlate, date: date)
        //ReceiptController.updateReceipt(receipt: receipt, oldTitle: oldTitle)
        //tableView.reloadData()
    }
    
    /******************************************************************
     * Method: deleteReceipt(indexPath)
     * Description: Deletes a specific index number passed to it.
     *****************************************************************/
    private func deleteReceipt(indexPath: IndexPath) {
        let receipt = ReceiptController.getAllReceipts()![indexPath.row]
        let title = receipt.value(forKeyPath: "title") as! String
        ReceiptController.deleteReceipt(title: title)
        tableView.reloadData()
    }
    
    /******************************************************************
     * Method: displayEditReceipt(indexPath)
     * Description: Displays Alert Box for editing Receipt
     *****************************************************************/
    private func displayEditReceipt(indexPath: IndexPath) {
        
        //let addAlert = UIAlertController(title: "Edit Receipt", message: "Edit Receipt Details", preferredStyle: .alert)
        
        let nsObj = ReceiptController.getAllReceipts()![indexPath.row]
        let receipt = ReceiptController.receiptFromNSManagedObject(obj: nsObj)
        
        
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewReceiptVC = mainSB.instantiateViewController(withIdentifier: "ViewReceipt") as! ViewReceiptVC
        viewReceiptVC.receipt = receipt

        navigationController?.pushViewController(viewReceiptVC, animated: true)
    }
    
}

