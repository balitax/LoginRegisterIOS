//
//  SignupController.swift
//  Todo Apps
//
//  Created by abc on 11/21/15.
//  Copyright © 2015 ayowes. All rights reserved.
//

import UIKit
import Bolts
import Parse
import FlatUIKit

class SignupController: UIViewController , UIViewControllerTransitioningDelegate {

    @IBOutlet weak var txUsername: FUITextField!
    @IBOutlet weak var txPassword: FUITextField!
    @IBOutlet weak var txPasswordConfirmation: FUITextField!
    @IBOutlet weak var txEmail: FUITextField!
    @IBOutlet weak var buttonRegister: FUIButton!
    @IBOutlet weak var buttonLogin: FUIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "headerBg"), forBarMetrics: UIBarMetrics.Default)
        self.title = "Register Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icBack"
        )
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icBack")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgVote2")!)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Remove separator under header
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        // FlatUIKit Set
        
        txUsername.font = UIFont .flatFontOfSize(16)
        txUsername.backgroundColor = UIColor .clearColor()
        txUsername.textFieldColor = UIColor .whiteColor()
        txUsername.borderColor = UIColor .turquoiseColor()
        txUsername.borderWidth = 2.0
        txUsername.cornerRadius = 3.0
        
        txPassword.font = UIFont .flatFontOfSize(16)
        txPassword.backgroundColor = UIColor .clearColor()
        txPassword.textFieldColor = UIColor .whiteColor()
        txPassword.borderColor = UIColor .turquoiseColor()
        txPassword.borderWidth = 2.0
        txPassword.cornerRadius = 3.0
        
        txPasswordConfirmation.font = UIFont .flatFontOfSize(16)
        txPasswordConfirmation.backgroundColor = UIColor .clearColor()
        txPasswordConfirmation.textFieldColor = UIColor .whiteColor()
        txPasswordConfirmation.borderColor = UIColor .turquoiseColor()
        txPasswordConfirmation.borderWidth = 2.0
        txPasswordConfirmation.cornerRadius = 3.0
        
        txEmail.font = UIFont .flatFontOfSize(16)
        txEmail.backgroundColor = UIColor .clearColor()
        txEmail.textFieldColor = UIColor .whiteColor()
        txEmail.borderColor = UIColor .turquoiseColor()
        txEmail.borderWidth = 2.0
        txEmail.cornerRadius = 3.0
        
        buttonLogin.buttonColor = UIColor .turquoiseColor()
        buttonLogin.shadowColor = UIColor .greenSeaColor()
        buttonLogin.shadowHeight = 3.0
        buttonLogin.cornerRadius = 6.0
        buttonLogin.titleLabel?.font = UIFont .boldFlatFontOfSize(16)
        
        buttonRegister.buttonColor = UIColor .turquoiseColor()
        buttonRegister.shadowColor = UIColor .greenSeaColor()
        buttonRegister.shadowHeight = 3.0
        buttonRegister.cornerRadius = 6.0
        buttonRegister.titleLabel?.font = UIFont .boldFlatFontOfSize(16)
    }

    @IBAction func btnRegister(sender: AnyObject) {
        let username = self.txUsername.text
        let password = self.txPassword.text
        let passwordAgain = self.txPasswordConfirmation.text
        let email = self.txEmail.text
        
        if username == "" {
            let alert = UIAlertView(title: "Invalid", message: "Username is required", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if password == "" {
            let alert = UIAlertView(title: "Invalid", message: "Password is required", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if passwordAgain == "" {
            let alert = UIAlertView(title: "Invalid", message: "Password confirmation is required", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if password != passwordAgain {
            let alert = UIAlertView(title: "Invalid", message: "Password confirmation incorrect", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if email == "" {
            let alert = UIAlertView(title: "Invalid", message: "Email is required", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if !isValidEmail(email!) {
            let alert = UIAlertView(title: "Invalid", message: "Wrong email address format", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else {
            // Aksi Register
            
            let alert: UIAlertView = UIAlertView(title: "", message: "Please wait...", delegate: nil, cancelButtonTitle: "");
            
            
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
            loadingIndicator.center = self.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            
            alert.setValue(loadingIndicator, forKey: "accessoryView")
            loadingIndicator.startAnimating()
            
            alert.show()

            
            let newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email    = email
            
            newUser.signUpInBackgroundWithBlock({(succed, error) -> Void in
                // Stop spinner
                alert.dismissWithClickedButtonIndex(-1, animated: true)
                
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Homes")
                        self.navigationController?.showViewController(viewController, sender: self)
})
                }
            })
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoLogin(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login")
        self.navigationController?.showViewController(viewController, sender: self)
    }

    
    @IBAction func backtoLogin(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login")
        self.navigationController?.showViewController(viewController, sender: self)

    }
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
   

}
