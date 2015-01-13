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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.usernameField = UITextField()
        self.usernameField.font = UIFont(name: "Lato-Regular", size: 16)
        self.usernameField.placeholder = "Username"
        self.usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        self.usernameField.returnKeyType = UIReturnKeyType.Next
        
        self.passwordField = UITextField()
        self.passwordField.font = UIFont(name: "Lato-Regular", size: 16)
        self.passwordField.placeholder = "Password"
        self.passwordField.secureTextEntry = true
        self.passwordField.autocapitalizationType = UITextAutocapitalizationType.None
        self.passwordField.returnKeyType = UIReturnKeyType.Go
        
        self.loginButton = UIButton()
        self.loginButton.titleLabel!.font = UIFont(name: "Lato-Regular", size: 16)
        self.loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.loginButton.setTitle("Login", forState: UIControlState.Normal)
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init() {
        self.usernameField = UITextField()
        self.usernameField.font = UIFont(name: "Lato-Regular", size: 16)
        self.usernameField.placeholder = "Username"
        self.usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        self.usernameField.returnKeyType = UIReturnKeyType.Next
        
        self.passwordField = UITextField()
        self.passwordField.font = UIFont(name: "Lato-Regular", size: 16)
        self.passwordField.placeholder = "Password"
        self.passwordField.secureTextEntry = true
        self.passwordField.autocapitalizationType = UITextAutocapitalizationType.None
        self.passwordField.returnKeyType = UIReturnKeyType.Go
        
        self.loginButton = UIButton()
        self.loginButton.titleLabel!.font = UIFont(name: "Lato-Regular", size: 16)
        self.loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.loginButton.setTitle("Login", forState: UIControlState.Normal)
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        
        super.init()
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.loginButton.addTarget(self, action: "loginTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func loadView() {
       let view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        view.backgroundColor = UIColor.whiteColor()
        
        let xMargin = CGFloat(20)
        let yMargin = CGFloat(20)
        
        let tableView = self.tableView
        tableView.frame = CGRectMake(xMargin, yMargin, floor(CGRectGetWidth(view.bounds) - 2 * xMargin), 132.0)
        tableView.layer.cornerRadius = 10
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = tableView.separatorColor.CGColor
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollEnabled = false
        view.addSubview(tableView)
        
        self.loginButton.frame = CGRectZero
        view.addSubview(self.loginButton)
        
        self.view = view
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        var frame = self.tableView.frame
        frame.size.width = floor(CGRectGetWidth(self.view.bounds) - 2 * 20)
        self.tableView.frame = frame
        
        var loginFrame = self.loginButton.frame
        loginFrame.size.width = CGRectGetWidth(frame)
        self.loginButton.frame = loginFrame
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let xOffset = CGFloat(20)
        
        switch (indexPath.row) {
        case 0:
            self.usernameField.frame = CGRectMake(xOffset, CGRectGetMinY(cell.frame), CGRectGetWidth(tableView.frame) - 2 * xOffset, CGRectGetHeight(cell.frame))
            cell.contentView.addSubview(self.usernameField)
        case 1:
            self.passwordField.frame = CGRectMake(xOffset, CGRectGetMinY(cell.frame), CGRectGetWidth(tableView.frame) - 2 * xOffset, CGRectGetHeight(cell.frame))
            cell.contentView.addSubview(self.passwordField)
        case 2:
            self.loginButton.frame = CGRectMake(CGRectGetMinX(cell.frame), CGRectGetMinY(cell.frame), CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.frame))
            cell.contentView.addSubview(self.loginButton)
        default:
            break
        }
        cell.frame = CGRectMake(CGRectGetMinX(cell.frame), CGRectGetMinY(cell.frame), CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.frame))
        cell.contentView.frame = CGRectMake(CGRectGetMinX(cell.contentView.frame), CGRectGetMinY(cell.contentView.frame), CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.contentView.frame))
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.usernameField) {
            self.passwordField.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
            self.loginTapped()
            return true
        }
    }
    
    func loginTapped() {
        if (self.validateFields()) {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            let manager = AFHTTPRequestOperationManager()
            let username = self.usernameField.text
            let parameters = [
                "username" : username,
                "password" : self.passwordField.text,
                "source": "android"
            ]
            
            manager.POST("http://itch.io/api/1/login", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                println("JSON: " + responseObject.description)
                },
                failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error: " + error.localizedDescription)
            })
            
        }
    }
    
    func validateFields() -> Bool {
        var error = ""
        
        if (self.usernameField.text == "" || self.passwordField.text == "") {
            error = "Username and password cannot be blank."
        }
        
        if (countElements(error) > 0) {
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { action in println("Ok") })
            alertController.addAction(OKAction)
        }
        return countElements(error) == 0
    }
}
