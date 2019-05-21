//
//  PublicViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 18/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit

class PublicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor.blue
        
        let uTextField = UITextField()
        uTextField.backgroundColor = UIColor.white
        uTextField.placeholder = "enterUName"
        self.view.addSubview(uTextField)
        uTextField.frame = CGRect(x: 15, y: 54, width: 300, height: 45)
        let pTextField = UITextField(frame: CGRect(x: 15, y: 90, width: 300, height: 45))
        pTextField.backgroundColor = UIColor.white
        pTextField.placeholder = "Password"
        self.view.addSubview(pTextField)
    
        
//        let myFirstLabel = UILabel()
//        let myFirstButton = UIButton()
//        myFirstLabel.text = "I made a label on the screen #toogood4you"
//        myFirstLabel.font = UIFont(name: "MarkerFelt-Thin", size: 25)
//        myFirstLabel.textColor = UIColor.red
//        myFirstLabel.textAlignment = .center
//        myFirstLabel.numberOfLines = 5
////        myFirstLabel.frame = CGRectMake(15, 54, 300, 500)
//        myFirstLabel.frame = CGRect(x: 15, y: 54, width: 300, height: 45)
//        myFirstButton.setTitle("✸", for: .normal)
//        myFirstButton.setTitleColor(UIColor.blue, for: .normal)
////        myFirstButton.frame = CGRect(15, -50, 300, 500)
//        myFirstButton.frame = CGRect(x: 15, y: -50, width: 300, height: 45)
//        myFirstButton.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
//        self.view.addSubview(myFirstLabel)
//        self.view.addSubview(myFirstButton)
    }
    @objc func pressed(sender: UIButton!) {
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
