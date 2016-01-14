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
            title: nil,
            message : nil,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Cancel, handler: nil))
        return alert
    }()
    
    
    func checkFields() ->Bool {
        return !(UsernameField.text?.isEmpty ?? true
            || PasswordField.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn() {
        if isLoading {
            return
        }
        if checkFields() {
            isLoading = true
            PFUser.logInWithUsernameInBackground(UsernameField.text!, password: PasswordField.text!) {
                [unowned self]
                (user: PFUser?, error: NSError?) -> Void in
                self.isLoading = false
                if user != nil {
                    // Do stuff after successful login.
                    self.showMainScreen()
                } else {
                    // The login failed. Check error to see why.
                    let errorString = error!.userInfo["error"] as? String
                    self.alert.message = errorString
                    self.presentViewController(self.alert, animated: true, completion: nil)
                    
                    
                }
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

