//
//  AppMainViewController.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 4/30/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class AppMainViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goBackToOriginViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
