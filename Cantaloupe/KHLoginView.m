//
//  KHLoginView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/29/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHLoginView.h"

@interface KHLoginView()

@property (nonatomic, strong) UIView *formContainer;
@property (nonatomic, strong) UIView *usernameSpacer;
@property (nonatomic, strong) UIView *passwordSpacer;

@property (nonatomic, assign) BOOL loginFormVisible;
@property (nonatomic, strong) MASConstraint *formPositionConstraint;

@end

@implementation KHLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _loginFormVisible = NO;
        
        _formContainer = [[UIView alloc] init];
        _formContainer.backgroundColor = [UIColor whiteColor];
        [self addSubview:_formContainer];
        
        _usernameField = [[UITextField alloc] init];
        _usernameField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _usernameField.placeholder = NSLocalizedString(@"Username", nil);
        _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
        _usernameField.returnKeyType = UIReturnKeyNext;
        _usernameField.backgroundColor = [UIColor colorFromHexString:@"F2F2F2"];
        [_formContainer addSubview:_usernameField];
        
        _usernameSpacer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_usernameField setLeftViewMode:UITextFieldViewModeAlways];
        [_usernameField setLeftView:_usernameSpacer];
        
        _passwordField = [[UITextField alloc] init];
        _passwordField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _passwordField.placeholder = NSLocalizedString(@"Password", nil);
        _passwordField.secureTextEntry = YES;
        _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordField.returnKeyType = UIReturnKeyGo;
        _passwordField.backgroundColor = [UIColor colorFromHexString:@"F2F2F2"];
        [_formContainer addSubview:_passwordField];
        
        _passwordSpacer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_passwordField setLeftViewMode:UITextFieldViewModeAlways];
        [_passwordField setLeftView:_passwordSpacer];
        
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:NSLocalizedString(@"Sign in", nil) forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:20.0f];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor linkColor]];
        [_formContainer addSubview:_loginButton];
        
        self.backgroundColor = [UIColor darkBackgroundColor];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    CGFloat margin = 10.f;
    CGFloat verticalHeight = 44.0f;
    [self.formContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(margin);
        make.right.equalTo(self).with.offset(-margin);
        
        if (self.loginFormVisible) {
            self.formPositionConstraint = make.centerY.equalTo(self.mas_centerY);
        } else {
            self.formPositionConstraint = make.bottom.equalTo(self.mas_top);
        }
    }];
    
    [self.usernameField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formContainer).with.offset(margin);
        make.right.equalTo(self.formContainer).with.offset(-margin);
        make.top.equalTo(self.formContainer).with.offset(margin);
        make.height.equalTo(@(verticalHeight));
    }];
    
    [self.passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.usernameField);
        make.top.equalTo(self.usernameField.mas_bottom).with.offset(margin);
        make.height.equalTo(@(verticalHeight));
    }];
    
    [self.loginButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.usernameField);
        make.top.equalTo(self.passwordField.mas_bottom).with.offset(margin);
        make.bottom.equalTo(self.formContainer).with.offset(-margin);
        make.height.equalTo(@(verticalHeight));
    }];
    [super updateConstraints];
}

- (void)animate {
    self.loginFormVisible = YES;
    
    [self.formPositionConstraint uninstall];
    
    [UIView animateWithDuration:0.7f
                          delay:0.0f
         usingSpringWithDamping:0.8f
          initialSpringVelocity:0.0f
                        options:0
                     animations:^{
                         [self setNeedsUpdateConstraints];
                         [self layoutIfNeeded];
                     }
                     completion:nil];
}

@end
