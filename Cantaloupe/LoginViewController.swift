//
//  LoginViewController.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 10/3/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let usernameField:UITextField
    let passwordField:UITextField
    let loginButton:UIButton
    let tableView:UITableView
    
    let kCellIdentifier = "loginCell"
    let kKeychainServicekey = "com.khwang.Cantaloupe"
    let kUserKey = "kCantaloupeCurrentUser"
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        self.usernameField = UITextField()
        self.usernameField.font = UIFont(name: "Lato-Regular", size: 16)
        self.usernameField.placeholder = "Username"
        self.usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        self.usernameField.returnKeyType = UIReturnKeyType.Next
        self.usernameField.delegate = self
        
        self.passwordField = UITextField()
        self.passwordField.font = UIFont(name: "Lato-Regular", size: 16)
        self.passwordField.placeholder = "Password"
        self.passwordField.secureTextEntry = true
        self.passwordField.autocapitalizationType = UITextAutocapitalizationType.None
        self.passwordField.returnKeyType = UIReturnKeyType.Go
        self.passwordField.delegate = self
        
        self.loginButton = UIButton()
        self.loginButton.titleLabel!.font = UIFont(name: "Lato-Regular", size: 16)
        self.loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.loginButton.setTitle("Login", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: "loginTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        super.init()
    }
    
    override func loadView() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
