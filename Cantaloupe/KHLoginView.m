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

@end
@implementation KHLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _formContainer = [[UIView alloc] init];
        [self addSubview:_formContainer];
        
        _usernameField = [[UITextField alloc] init];
        _usernameField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _usernameField.placeholder = NSLocalizedString(@"Username", nil);
        _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameField.returnKeyType = UIReturnKeyNext;
        [_formContainer addSubview:_usernameField];
        
        _passwordField = [[UITextField alloc] init];
        _passwordField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _passwordField.placeholder = NSLocalizedString(@"Password", nil);
        _passwordField.secureTextEntry = YES;
        _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordField.returnKeyType = UIReturnKeyGo;
        [_formContainer addSubview:_passwordField];
        
        self.backgroundColor = [UIColor whiteColor];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    CGFloat margin = 20.f;
    [self.formContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(margin);
        make.right.equalTo(self).with.offset(-margin);
        make.centerY.equalTo(self);
        make.height.equalTo(@100);
    }];
    
    [self.usernameField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formContainer).with.offset(margin);
        make.right.equalTo(self.formContainer).with.offset(-margin);
        make.top.equalTo(self.formContainer);
    }];
    
    [self.passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.usernameField);
        make.top.equalTo(self.usernameField.mas_bottom);
        make.bottom.equalTo(self.formContainer);
    }];
    [super updateConstraints];
}

@end
