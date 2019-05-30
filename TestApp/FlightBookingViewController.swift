//
//  FlightBookingViewController.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 5/3/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class FlightBookingViewController: UIViewController, UITextFieldDelegate {
    var flights: Itineraries?
    
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var departureDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flights = Itineraries()
     }

        
    @IBAction func goBackToOriginViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showSearchResults(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? SearchResultsViewController {
            nextVC.itineraries = self.flights?.itineraries
        }
    }

}
