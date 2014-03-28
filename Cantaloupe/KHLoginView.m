//
//  KHLoginView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginView.h"

@interface KHLoginView()

@end

@implementation KHLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20.0f, frame.size.width, 20.0f)];
        self.usernameField.placeholder = @"Username";
        self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.usernameField.returnKeyType = UIReturnKeyNext;
        self.usernameField.textColor = [UIColor whiteColor];
        [self addSubview:self.usernameField];
        
        self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 40.0f, frame.size.width, 20.0f)];
        self.passwordField.placeholder = @"Password";
        self.passwordField.secureTextEntry = YES;
        self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.passwordField.returnKeyType = UIReturnKeyGo;
        self.passwordField.textColor = [UIColor whiteColor];
        [self addSubview:self.passwordField];
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 60.0f, frame.size.width, 20.0f)];
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self addSubview:self.loginButton];
    }
    return self;
}

- (void)layoutSubviews {
    [self.usernameField sizeToFit];
    CGFloat xPoint = floorf((self.frame.size.width - self.usernameField.frame.size.width) / 2);
    
    self.usernameField.frame = CGRectMake(xPoint, 20.0f, self.usernameField.frame.size.width, self.usernameField.frame.size.height);
    
    self.passwordField.frame = CGRectMake(xPoint, self.usernameField.frame.origin.y + 40.0f, self.usernameField.frame.size.width, self.usernameField.frame.size.height);
    
    self.loginButton.frame = CGRectMake(xPoint, self.passwordField.frame.origin.y + 40.0f, self.usernameField.frame.size.width, self.usernameField.frame.size.height);
}

@end
