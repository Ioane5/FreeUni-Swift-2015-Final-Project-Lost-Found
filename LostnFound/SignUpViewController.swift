//
//  SignUpViewController.swift
//  LostnFound
//
//  Created by Ioane Sharvadze on 1/9/16.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PhoneFieled: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PasswordReField: UITextField!
    
    lazy var alert : UIAlertController = {
        var alert = UIAlertController(
            title: "Alert",
            message : "Please fill all fields",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Cancel, handler: nil))
        return alert
    }()
    
    func checkFields() ->Bool {
        return !(UsernameField.text?.isEmpty ?? true
            && EmailField.text?.isEmpty ?? true
            && PhoneFieled.text?.isEmpty ?? true
            && PasswordField.text?.isEmpty ?? true
            && PasswordReField.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUp() {
        if checkFields() {
            let user = PFUser()
            user.username = UsernameField.text
            user.password = PasswordReField.text
            user.email = EmailField.text
            user["phone"] = PhoneFieled.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    // Show the errorString somewhere and let the user try again.
                    self.alert.message = errorString
                    self.presentViewController(self.alert, animated: true, completion: nil)
                } else {
                    // Hooray! Let them use the app now.
                }
            }
        } else {
            // show dialog
            alert.title = "empty_fields_title".localized
            alert.message = "empty_fields_message".localized
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}
