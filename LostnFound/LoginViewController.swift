//
//  ViewController.swift
//  LostnFound
//
//  Created by Ioane Sharvadze on 12/10/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit
import Parse

class LoginController: UIViewController {
    
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    lazy var alert : UIAlertController = {
        var alert = UIAlertController(
            title: nil,
            message : nil,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Cancel, handler: nil))
        return alert
    }()
    
    
    func checkFields() ->Bool {
        return !(UsernameField.text?.isEmpty ?? true
            && PasswordField.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn() {
        if checkFields() {
            
        } else {
            // show dialog
            alert.title = "empty_fields_title".localized
            alert.message = "empty_fields_message".localized
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
}

