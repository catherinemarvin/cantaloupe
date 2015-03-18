//
//  KHLoginView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/29/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHLoginView.h"

// Fonts
#import "UIFont+KHAdditions.h"

@interface KHLoginView()

@property (nonatomic, strong) UIImageView *backgroundImage;

@property (nonatomic, strong) UIImageView *logo;

@property (nonatomic, strong) UIView *formContainer;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIView *divider;

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIView *usernameSpacer;
@property (nonatomic, strong) UITextField *usernameField;

@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UIView *passwordSpacer;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, assign) BOOL loginFormVisible;
@property (nonatomic, strong) MASConstraint *formPositionConstraint;

@end

@implementation KHLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _loginFormVisible = NO;
        
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"login_background.jpg"];
        _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImage.userInteractionEnabled = YES;
        [self addSubview:_backgroundImage];
        
        _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        _logo.contentMode = UIViewContentModeScaleAspectFit;
        [_backgroundImage addSubview:_logo];
        
        _formContainer = [[UIView alloc] init];
        _formContainer.backgroundColor = [UIColor whiteColor];
        [_backgroundImage addSubview:_formContainer];
        
        _header = [[UIView alloc] init];
        [_formContainer addSubview:_header];
        
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = NSLocalizedString(@"Login", nil);
        _headerLabel.font = [UIFont boldWithSize:16];
        [_header addSubview:_headerLabel];
        
        _divider = [[UIView alloc] init];
        _divider.backgroundColor = [UIColor colorFromHexString:@"D1D1D1"];
        [_formContainer addSubview:_divider];
        
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.font = [UIFont regularWithSize:16];
        _usernameLabel.text = NSLocalizedString(@"Username", nil);
        [_formContainer addSubview:_usernameLabel];
        
        _usernameField = [[UITextField alloc] init];
        _usernameField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
        _usernameField.returnKeyType = UIReturnKeyNext;
        _usernameField.backgroundColor = [UIColor colorFromHexString:@"F2F2F2"];
        [_formContainer addSubview:_usernameField];
        
        _usernameSpacer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_usernameField setLeftViewMode:UITextFieldViewModeAlways];
        [_usernameField setLeftView:_usernameSpacer];
        
        _passwordLabel = [[UILabel alloc] init];
        _passwordLabel.font = [UIFont regularWithSize:16.0f];
        _passwordLabel.text = NSLocalizedString(@"Password", nil);
        [_formContainer addSubview:_passwordLabel];
        
        _passwordField = [[UITextField alloc] init];
        _passwordField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
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
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    CGFloat margin = 10.f;
    CGFloat verticalHeight = 44.0f;
    
    [self.backgroundImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.logo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImage);
        make.top.equalTo(self.backgroundImage).with.offset(margin);
    }];
    
    [self.formContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundImage).with.offset(margin);
        make.right.equalTo(self.backgroundImage).with.offset(-margin);
        
        if (self.loginFormVisible) {
            self.formPositionConstraint = make.centerY.equalTo(self.backgroundImage.mas_centerY);
        } else {
            self.formPositionConstraint = make.bottom.equalTo(self.backgroundImage.mas_top);
        }
    }];
    
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.formContainer);
        make.left.and.right.equalTo(self.formContainer);
        make.height.equalTo(self.headerLabel).multipliedBy(2);
    }];
    
    [self.headerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.header);
        make.left.equalTo(self.header).with.offset(margin);
    }];
    
    [self.divider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.formContainer);
        make.top.equalTo(self.header.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formContainer).with.offset(margin);
        make.right.equalTo(self.formContainer).with.offset(-margin);
        make.top.equalTo(self.divider).with.offset(margin);
    }];
    
    [self.usernameField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formContainer).with.offset(margin);
        make.right.equalTo(self.formContainer).with.offset(-margin);
        make.top.equalTo(self.usernameLabel.mas_bottom).with.offset(margin);
        make.height.equalTo(@(verticalHeight));
    }];
    
    [self.passwordLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.usernameField);
        make.top.equalTo(self.usernameField.mas_bottom).with.offset(margin);
    }];
    
    [self.passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.usernameField);
        make.top.equalTo(self.passwordLabel.mas_bottom).with.offset(margin);
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
