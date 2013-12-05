//
//  LoginController.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginController.h"
#import "MainController.h"

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![AppContext instance].option.protect) {
        [self pushViewController:[MainController class]];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [_passwordField becomeFirstResponder];
}

- (void)initView {
    
    [super initView];
    [_titleView setBackEnabled:NO];
    [_titleView setIcon:[UIImage imageNamed:I(@"icon_user")]];
    [_titleView setText:T(@"LOGIN")];
    [_titleView layout];
    
    [_loginButton setEnabled:NO];
    [_loginButton setTarget:self];
    [_loginButton setAction:@selector(onLoginClick:)];
    [_loginButton setText:T(@"LET ME IN")];
    [_loginButton layout];
}

#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [_passwordField.text stringByReplacingCharactersInRange:range withString:string];
    _loginButton.enabled = newText.length >= 6;
    return YES;
}

#pragma mark - Actions

- (void)onLoginClick:(id)sender {
    if ([_passwordField.text isEqualToString:[AppContext instance].option.password]) {
        _passwordField.text = @"";
        _loginButton.enabled = NO;
        [self pushViewController:[MainController class]];
    } else {
        [self alert:@"Password incorrect"];
    }
}

@end
