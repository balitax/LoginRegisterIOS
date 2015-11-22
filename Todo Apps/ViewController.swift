//
//  ViewController.swift
//  Todo Apps
//
//  Created by abc on 1/1/01.
//  Copyright © 2001 ayowes. All rights reserved.
//

import UIKit
import Bolts
import Parse
import FlatUIKit

class ViewController: UIViewController {

    @IBOutlet weak var txUsername: FUITextField!
    @IBOutlet weak var txPassword: FUITextField!
    @IBOutlet weak var buttonLogin: FUIButton!
    @IBOutlet weak var buttonRegister: FUIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "headerBg"), forBarMetrics: UIBarMetrics.Default)
        self.title = "Todo Parse"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icBack"
        )
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icBack")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgVote2")!)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setHidesBackButton(true, animated:true)
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
        txUsername.edgeInsets = UIEdgeInsetsMake(4.0, 15.0, 4.0, 15.0)
        txUsername.textFieldColor = UIColor .whiteColor()
        txUsername.borderColor = UIColor .turquoiseColor()
        txUsername.borderWidth = 2.0
        txUsername.cornerRadius = 3.0
        
        txPassword.font = UIFont .flatFontOfSize(16)
        txPassword.backgroundColor = UIColor .clearColor()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(sender: AnyObject) {
        let username = self.txUsername.text
        let password = self.txPassword.text
        
        if username == "" {
            let alert = UIAlertView(title: "Invalid", message: "Please input username first", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if password == "" {
            let alert = UIAlertView(title: "Invalid", message: "Please input password too", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else {
            
            let alert: UIAlertView = UIAlertView(title: "", message: "Please wait...", delegate: nil, cancelButtonTitle: "");
            
            
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
            loadingIndicator.center = self.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            
            alert.setValue(loadingIndicator, forKey: "accessoryView")
            loadingIndicator.startAnimating()
            
            alert.show()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner

                alert.dismissWithClickedButtonIndex(-1, animated: true)
                
                if ((user) != nil) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Homes")
                        self.navigationController?.showViewController(viewController, sender: self)
                        
                    })
                    
                } else {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }

    @IBAction func goRegister(sender: AnyObject) {
        
    }

}










