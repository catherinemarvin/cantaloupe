//
//  SettingsViewCell.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/24/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class SettingsViewCell : UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier) // Ignore whatever value we get, use Value1 style.
        
        self.textLabel!.font = UIFont(name: "Lato-Regular", size: 16)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
