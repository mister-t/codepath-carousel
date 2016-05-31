//
//  LoginViewController.swift
//  carousel
//
//  Created by Tony Yeung on 5/30/16.
//  Copyright © 2016 Tony Yeung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonParentView: UIView!
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    @IBOutlet weak var loginNavBar: UIImageView!
    @IBOutlet weak var fieldParentView: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    var alertController: UIAlertController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
        
        //Allow the scrollView to scroll up just enough to hide the login text ImageView.
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        alertController = UIAlertController(title: "Email/Password Required", message: "Please enter both email and password", preferredStyle: .Alert)
        
        // create a cancel action
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
//            // handle cancel response here. Doing nothing will dismiss the view.
//        }
        // add the cancel action to the alertController
//        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)

    }
    @IBAction func signInDidPressed(sender: AnyObject) {
        print("login in button pressed")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tutorialVC = mainStoryboard.instantiateViewControllerWithIdentifier("tutorialVC") as! TutorialsViewController
        loginIndicator.startAnimating()
        loginButton.selected = true
        
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            print("email or password is empty")

                self.loginIndicator.stopAnimating()
                self.loginButton.selected = false
                alertController.title = "Email/Password Required"
                alertController.message = "Please enter both email and password"
                self.presentViewController(self.alertController, animated: true,completion: nil)
        } else if emailField.text == "tony@gmail.com" &&  passwordField.text == "password" {
            delay(2, closure: { () -> () in
                self.loginIndicator.stopAnimating()
                self.loginButton.selected = false
                self.presentViewController(tutorialVC, animated: true, completion: nil)
                 })
        } else {
            self.loginIndicator.stopAnimating()
            self.loginButton.selected = false
            alertController.title = "Wrong Email/Password"
            alertController.message = "Please enter your email and password again"
            self.presentViewController(self.alertController, animated: true,completion: nil)
        }
        

    }
    // The main view is about to appear...
    override func viewWillAppear(animated: Bool) {
        // Set initial transform values 20% of original size
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        // Apply the transform properties of the views
        loginNavBar.transform = transform
        fieldParentView.transform = transform
        // Set the alpha properties of the views to transparent
        loginNavBar.alpha = 0
        fieldParentView.alpha = 0
    }
    // The main view appeared...
    override func viewDidAppear(animated: Bool) {
        //Animate the code within over 0.3 seconds...
        UIView.animateWithDuration(0.3) { () -> Void in
            // Return the views transform properties to their default states.
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.loginNavBar.transform = CGAffineTransformIdentity
            // Set the alpha properties of the views to fully opaque
            self.fieldParentView.alpha = 1
            self.loginNavBar.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("will show keyboard")
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    func keyboardWillHide(notification: NSNotification) {
//        print("will hide keyboard")
        // Move the buttons back down to it's original position
        buttonParentView.frame.origin.y = buttonInitialY
    }
    // The scrollView is in the proccess of scrolling...
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y <= -50 {
            // Hide the keyboard
            view.endEditing(true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
