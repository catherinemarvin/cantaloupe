//
//  SettingsViewController.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/26/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum SettingCell:Int {
        case None = 0
        case Logout
        case Username
        case Contact
    }
    
    let kSettingsCellIdentifier = "kSettingsCell"
    let kSectionHeaderHeight = 30.0
    
    var settingItems:Array<SettingCell>
    var userItems:Array<SettingCell>
    var helpItems:Array<SettingCell>
    
    override init(style: UITableViewStyle) {
        self.settingItems = [SettingCell.Logout]
        self.userItems = [SettingCell.Username]
        self.helpItems = [SettingCell.Contact]
        super.init(style: style)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        self.tableView.registerClass(SettingsViewCell.self, forCellReuseIdentifier: kSettingsCellIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: Integrate with google analytics
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.settingItems.count
        } else if (section == 1) {
            return self.userItems.count
        } else if (section == 2) {
            return self.helpItems.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewFrame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGFloat(kSectionHeaderHeight))
        let headerView = UIView(frame: headerViewFrame)
        
        let leftPadding = CGFloat(15.0)
        
        let headerFrame = CGRectMake(leftPadding, 0, CGRectGetWidth(tableView.bounds) - leftPadding, CGFloat(kSectionHeaderHeight))
        let header = UILabel(frame: headerFrame)
        
        var text:NSString
        
        if (section == 0) {
            text = "MANAGEMENT"
        } else if (section == 1) {
            text = "INFORMATION"
        } else if (section == 2) {
            text = "HELP"
        } else {
            text = "????"
        }
        
        header.text = text
        header.font = UIFont(name: "Lato-Regular", size: 14)
        header.textColor = UIColor.grayColor()
        headerView.addSubview(header)
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(kSectionHeaderHeight)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kSettingsCellIdentifier, forIndexPath: indexPath) as SettingsViewCell
        
        self.customizeCell(cell, indexPath:indexPath)
        return cell
    }
    
    func customizeCell(cell: SettingsViewCell, indexPath:NSIndexPath) {
        var cellType = SettingCell.None
        
        var backingData:Array<SettingCell>
        
        if (indexPath.section == 0) {
            backingData = self.settingItems
        } else if (indexPath.section == 1) {
            backingData = self.userItems
        } else if (indexPath.section == 2) {
            backingData = self.helpItems
        } else {
            return
        }
        
        let row = indexPath.row
        if (row < backingData.count) {
            cellType = backingData[row]
        }
        
        switch cellType {
        case .Logout:
            cell.textLabel!.text = "Logout"
            cell.tag = SettingCell.Logout.toRaw()
            break
        case .Username:
            cell.textLabel!.text = "Username"
            cell.detailTextLabel!.text = "My username here"
            cell.tag = SettingCell.Username.toRaw()
        case .Contact:
            cell.textLabel!.text = "Contact"
            cell.tag = SettingCell.Contact.toRaw()
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        switch cell!.tag {
        case SettingCell.Logout.toRaw():
            NSLog("Logout")
            break
        case SettingCell.Contact.toRaw():
            self.composeMail()
            break
        default:
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            break
        }
    }
    
    func composeMail() {
        if (!MFMailComposeViewController.canSendMail()) {
            let alert = UIAlertView(title: "Sorry", message: "Your account is not set up to send e-mails", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setToRecipients(["k3vinhwang@gmail.com"])
        mailController.setSubject("Itch.io App Feedback")
        self.presentViewController(mailController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}