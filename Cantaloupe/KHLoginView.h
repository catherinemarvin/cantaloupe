//
//  KHLoginView.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/29/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHLoginView : UIView

@property (nonatomic, strong, readonly) UITextField *usernameField;
@property (nonatomic, strong, readonly) UITextField *passwordField;
@property (nonatomic, strong, readonly) UIButton *loginButton;
@property (nonatomic, strong, readonly) UIView *formContainer;

- (void)animate;

@end
