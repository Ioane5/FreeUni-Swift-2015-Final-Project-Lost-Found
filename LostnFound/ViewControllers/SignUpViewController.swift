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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var isLoading = false {
        didSet {
            if isLoading {
                spinner?.startAnimating()
            } else {
                spinner?.stopAnimating()
            }
        }
    }
    
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
            || EmailField.text?.isEmpty ?? true
            || PhoneFieled.text?.isEmpty ?? true
            || PasswordField.text?.isEmpty ?? true
            || PasswordReField.text?.isEmpty ?? true)
    }
    
    func passwordsMatch() -> Bool {
        return PasswordField.text == PasswordReField.text
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
            if passwordsMatch() {
                let user = PFUser()
                user.username = UsernameField.text
                user.password = PasswordReField.text
                user.email = EmailField.text
                user["phone"] = PhoneFieled.text
                isLoading = true
                user.signUpInBackgroundWithBlock { [unowned self]
                    (succeeded: Bool, error: NSError?) -> Void in
                    self.isLoading = false
                    if let error = error {
                        let errorString = error.userInfo["error"] as? String
                        // Show the errorString somewhere and let the user try again.
                        self.alert.message = errorString
                        self.presentViewController(self.alert, animated: true, completion: nil)
                    } else {
                        // Hooray! Let them use the app now.
                        self.showMainScreen()
                    }
                }
            } else {
                alert.title = "Try Again"
                alert.message = "Passwords don't match."
                presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            // show dialog
            alert.title = "Try Again"
            alert.message = "Please fill all fields."
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func showMainScreen() {
        let mainScreen = self.storyboard?.instantiateViewControllerWithIdentifier("MainScreen") as? MainScreenViewController
        self.presentViewController(mainScreen!, animated: true, completion: nil)
    }
    
    
}
