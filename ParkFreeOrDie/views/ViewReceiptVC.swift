//
//  EditReceiptVC.swift
//  ParkFreeOrDie
//
//  Created by jermey on 2019-11-25.
//  Copyright © 2019 MerinClark Ltd. All rights reserved.
//

import UIKit

class ViewReceiptVC: UIViewController {
    
    @IBOutlet weak var streetNameLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var postalCodeLabel: UITextField!
    @IBOutlet weak var countryLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var hoursParkedLabel: UITextField!
    @IBOutlet weak var costLabel: UITextField!
    
    var receipt : Receipt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streetNameLabel.text = receipt?.street
        cityLabel.text = receipt?.city
        postalCodeLabel.text = receipt?.postal
        countryLabel.text = receipt?.country
        hoursParkedLabel.text = String(receipt!.hoursParked)
        costLabel.text = String(receipt!.cost)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
