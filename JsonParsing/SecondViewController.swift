//
//  SecondViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit
protocol sendObjectDelegate {
    func sendButtonTap(name:String)
}


class SecondViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    var selectionDelegate: sendObjectDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        selectionDelegate.sendButtonTap(name: nameTextField.text!)
        dismiss(animated: true, completion: nil)
    }
    
}
