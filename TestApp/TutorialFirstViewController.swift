//
//  TutorialFirstViewController.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 4/19/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class TutorialFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goBackToOriginViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
