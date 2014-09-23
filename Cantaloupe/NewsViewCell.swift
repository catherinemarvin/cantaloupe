//
//  NewsViewCell.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/22/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class NewsViewCell: UICollectionViewCell {
    
    var titleLabel:UILabel
    
    var news:Dictionary<NSString, AnyObject>?
    
    override init(frame: CGRect) {
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "Lato-Regular", size: 16.0)
        self.titleLabel.textColor = UIColor.blackColor()
        super.init(frame: frame)
        
        self.contentView.addSubview(self.titleLabel)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithNews(news: Dictionary<NSString, AnyObject>) -> Void {
        self.news = news
        
        if let title = self.news!["title"] as? NSString {
            self.titleLabel.text = title
        }
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.sizeToFit()
        var titleFrame = self.titleLabel.frame
        titleFrame.origin.x = 0
        titleFrame.origin.y = 0
        self.titleLabel.frame = titleFrame
    }
    
}
