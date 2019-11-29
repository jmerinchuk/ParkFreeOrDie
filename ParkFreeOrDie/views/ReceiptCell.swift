/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: ReceiptCell.swift
 * Desccription: Manages the Cell details for the receipt list.
 *****************************************************************/

// Imports
import UIKit

/*****************************************************************
 * Class: ReceiptCell : UITableViewCell
 * Description: Configuration of Table Cell
*****************************************************************/
class ReceiptCell: UITableViewCell {
    
    // Outlets
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblSubtitle : UILabel!
    @IBOutlet var lblTotal: UILabel!

    /*************************************************************
     * Method: awakeFromNib()
     * Description: Initial Loaded Function
    *************************************************************/
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /*************************************************************
     * Method: setSelected()
     * Description: Configure state of selected cell
    *************************************************************/
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
