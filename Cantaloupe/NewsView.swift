//
//  NewsView.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/22/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class NewsView: UIView {
    
    var title:UILabel
    var text:UILabel
    var news:Dictionary<NSString, AnyObject>?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, news: Dictionary<NSString, AnyObject>) {
        self.news = news
        self.title = UILabel()
        
        if let title = self.news!["title"] as? NSString {
            self.title.text = title
        }
        
        self.text = UILabel()
        if let body = self.news!["body"] as? NSString {
            self.text.text = body
        }
        self.text.numberOfLines = 0
        
        super.init(frame: frame)
        self.addSubview(self.title)
        self.addSubview(self.text)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.title.sizeToFit()
        
        var titleFrame = self.title.frame
        titleFrame.origin.x = 0
        titleFrame.origin.y = 0
        self.title.frame = titleFrame
        
        var textFrame = self.text.frame
        textFrame.origin.x = 0
        textFrame.origin.y = CGRectGetHeight(titleFrame) + 10
        textFrame.size.width = CGRectGetWidth(self.frame)
        self.text.frame = textFrame
        self.text.sizeToFit()
    }

}
