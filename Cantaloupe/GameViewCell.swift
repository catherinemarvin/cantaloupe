//
//  GameViewCell.swift
//  Cantaloupe
//
//  Created by Kevin Hwang on 9/25/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

import UIKit

class GameViewCell: UICollectionViewCell {
    
    let imageView:UIImageView
    let titleLabel:UILabel
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.clipsToBounds = true
        
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "Lato-Regular", size: 16)
        self.titleLabel.textColor = UIColor.whiteColor()
        
        super.init(frame: frame)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.imageView.frame = self.bounds
        let shadow = UIView(frame: self.imageView.bounds)
        shadow.backgroundColor = UIColor.blackColor()
        shadow.layer.opacity = 0.5
        self.imageView.addSubview(shadow)
        
        self.titleLabel.frame = CGRectMake(10, floor(CGRectGetMinY(self.bounds) / 2), CGRectGetWidth(self.bounds) - 10, 20)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGameImage(url: String?) {
        var image:UIImage
        
        if ((url) != nil) {
            image = UIImage(data: NSData(contentsOfURL: NSURL(string: url!)))
        } else {
            image = UIImage(named: "placeholder")
        }
        self.imageView.image = image
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
}
