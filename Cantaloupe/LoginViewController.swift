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
       let view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        view.backgroundColor = UIColor.whiteColor()
        
        let xMargin = CGFloat(20)
        let yMargin = CGFloat(20)
        
        let tableView = UITableView(frame: CGRectMake(xMargin, yMargin, floor(CGRectGetWidth(view.bounds) - 2 * xMargin), 132.0), style: UITableViewStyle.Grouped)
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
        self.tableView = tableView
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
