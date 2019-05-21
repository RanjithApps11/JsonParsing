//
//  FirstViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,sendObjectDelegate {

    func sendButtonTap(name: String) {
        enterValuelabel.text = name
    }
    
    
    @IBOutlet weak var enterValuelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        let selectedVc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        selectedVc.selectionDelegate = self as! sendObjectDelegate
        
        self.present(selectedVc, animated: true, completion: nil)
    }
    


}
