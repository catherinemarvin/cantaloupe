//
//  DetailedGameView.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/24/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class DetailedGameView: UIView {
    
    var gameData:Dictionary<NSString, AnyObject>
    
    let coverView:UIImageView
    
    let titleLabel:UILabel
    let descriptionLabel:UILabel
    let earningsLabel:UILabel
    let viewsLabel:UILabel
    let purchasesLabel:UILabel
    let downloadsLabel:UILabel
    
    // TODO:
    
    /*
self.earningsLabel.text = [NSString stringWithFormat: @"%@: %@", NSLocalizedString(@"Earnings", nil), [[data valueForKey:@"earnings"] valueForKey:@"amount_formatted"] ?: NSLocalizedString(@"None", @"Earnings: None")];
    
    self.viewsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Views", nil), [data valueForKey:@"views_count"]];
    
    self.purchasesLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Purchases", nil), [data valueForKey:@"purchases_count"]];
    
    self.downloadsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Downloads", nil), [data valueForKey:@"downloads_count"]];
*/
    
    init(frame: CGRect, data:Dictionary<NSString, AnyObject>) {
        self.gameData = data
        
        let coverUrlString = self.gameData["cover_url"] as NSString
        let coverUrl = NSURL(string: coverUrlString)
        let coverData = NSData(contentsOfURL: coverUrl)
        var coverImage = UIImage(data: coverData)
        
        self.coverView = UIImageView(image: coverImage)
        self.coverView.contentMode = UIViewContentMode.ScaleAspectFill
        self.coverView.clipsToBounds = true
        
        self.titleLabel = UILabel()
        self.titleLabel.text = self.gameData["title"] as NSString
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.font = UIFont(name: "Lato-Regular", size: 16)
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.text = self.gameData["short_text"] as NSString
        self.descriptionLabel.textColor = UIColor.whiteColor()
        self.descriptionLabel.font = UIFont(name: "Lato-Regular", size: 14)
        
        self.earningsLabel = UILabel()
        
        self.earningsLabel.text = NSString(format: "%@: %@", "Earnings", "1000")
        self.earningsLabel.textColor = UIColor.whiteColor()
        self.earningsLabel.font = UIFont(name: "Lato-Regular", size: 12)
        
        self.viewsLabel = UILabel()
        self.viewsLabel.text = NSString(format: "%@: %@", "Views", "2000")
        self.viewsLabel.textColor = UIColor.whiteColor()
        self.viewsLabel.font = UIFont(name: "Lato-Regular", size: 12)
        
        self.purchasesLabel = UILabel()
        self.purchasesLabel.text = NSString(format: "%@: %@", "Purchases", "3000")
        self.purchasesLabel.textColor = UIColor.whiteColor()
        self.purchasesLabel.font = UIFont(name: "Lato-Regular", size: 12)
        
        self.downloadsLabel = UILabel()
        self.downloadsLabel.text = NSString(format: "%@: %@", "Downloads", "4000")
        self.downloadsLabel.textColor = UIColor.whiteColor()
        self.downloadsLabel.font = UIFont(name: "Lato-Regular", size: 12)
        
        super.init(frame: frame)
        self.coverView.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.bounds), height: 200)
        self.addSubview(self.coverView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.earningsLabel)
        self.addSubview(self.viewsLabel)
        self.addSubview(self.purchasesLabel)
        self.addSubview(self.downloadsLabel)
        
        self.backgroundColor = UIColor.blackColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var coverViewFrame = self.coverView.frame
        coverViewFrame.origin.y = 10
        self.coverView.frame = coverViewFrame
        
        self.titleLabel.sizeToFit()
        
        var titleFrame = self.titleLabel.frame
        titleFrame.origin.x = CGRectGetMinX(self.coverView.frame) + 10
        titleFrame.origin.y = CGRectGetMaxY(self.coverView.frame) + 10
        self.titleLabel.frame = titleFrame
        
        self.descriptionLabel.sizeToFit()
        var descriptionFrame = self.descriptionLabel.frame
        descriptionFrame.origin.x = CGRectGetMinX(self.titleLabel.frame)
        descriptionFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 10
        self.descriptionLabel.frame = descriptionFrame
        
        self.earningsLabel.sizeToFit()
        var earningsFrame = self.earningsLabel.frame
        earningsFrame.origin.x = CGRectGetMinX(self.descriptionLabel.frame)
        earningsFrame.origin.y = CGRectGetMaxY(self.descriptionLabel.frame) + 20
        self.earningsLabel.frame = earningsFrame
        
        self.viewsLabel.sizeToFit()
        var viewsFrame = self.viewsLabel.frame
        viewsFrame.origin.x = CGRectGetMinX(self.earningsLabel.frame)
        viewsFrame.origin.y = CGRectGetMaxY(self.earningsLabel.frame) + 5
        self.viewsLabel.frame = viewsFrame
        
        self.purchasesLabel.sizeToFit()
        var purchasesFrame = self.purchasesLabel.frame
        purchasesFrame.origin.x = CGRectGetMinX(self.viewsLabel.frame)
        purchasesFrame.origin.y = CGRectGetMaxY(self.viewsLabel.frame) + 5
        self.purchasesLabel.frame = purchasesFrame
        
        self.downloadsLabel.sizeToFit()
        var downloadsFrame = self.downloadsLabel.frame
        downloadsFrame.origin.x = CGRectGetMinX(self.purchasesLabel.frame)
        downloadsFrame.origin.y = CGRectGetMaxY(self.purchasesLabel.frame) + 5
        self.downloadsLabel.frame = downloadsFrame
    }
}
