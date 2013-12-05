//
//  OptionController.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "OptionController.h"
#import "HelpController.h"
#import "StringUtils.h"

#define kAnimationDuration      0.3

@implementation OptionController

- (void)viewDidLoad {
    _option = [AppContext instance].option;
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    // un-register for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)initView {
    [super initView];
    [_titleView setBackEnabled:YES];
    [_titleView setIcon:[UIImage imageNamed:I(@"icon_option")]];
    [_titleView setText:T(@"OPTION")];
    [_titleView layout];
    
    [_scrollView addSubview:_contentView];
    _scrollView.contentSize = _contentView.frame.size;
    
    _protectSwitch.on = _option.protect;
    _passwordField.text = _option.password;
    _secretField.text = _option.secret;
    _key1Field.text = _option.key1;
    _key2Field.text = _option.key2;
    _wheelField.text = _option.wheel;
    _initialField.text = _option.initial;
    
    [_passwordStrengthView update:_option.password];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    [self moveKeyboard:YES forNotification:notification];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    [self moveKeyboard:NO forNotification:notification];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)moveKeyboard:(BOOL)moveUp forNotification:(NSNotification *)notification {
    if (_keyboardShown == moveUp) {
        return;
    }
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(self.interfaceOrientation)? keyboardSize.width : keyboardSize.height;
    CGRect viewFrame = _scrollView.frame;
    viewFrame.size.height += moveUp ? -keyboardHeight : keyboardHeight;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:kAnimationDuration];
    [_scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    _keyboardShown = moveUp;
    if (moveUp) {
        UIView *firstResponder = [_contentView findFirstResponder];
        if (firstResponder && [firstResponder isKindOfClass:[UITextField class]]) {
            [_scrollView scrollRectToVisible:firstResponder.frame animated:YES];
        }
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _passwordField) {
        NSString *newText = [_passwordField.text stringByReplacingCharactersInRange:range withString:string];
        [_passwordStrengthView update:newText];
        return YES;
    } else if (textField == _initialField) {
        if (string.length > 0) {
            _initialField.text = string;
        }
        return NO;
    }
    return YES;
}


#pragma mark - Actions

- (IBAction)onBackgroundClick:(id)sender {
    [self.view endEditing:YES];
}

- (void)onTitleViewClick:(TitleView*)sender {
    if (!_option.initialized) {
        [self alert:@"Please setup"];
    } else {
        if (sender.backEnabled) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)onSaveClick:(id)sender {
    if (_protectSwitch.isOn && _passwordStrengthView.securityLevel <= LEVEL_INVILID) {
        [self alert:@"Password invalid"];
        return;
    }
    if (stringIsEmpty(_secretField.text)) {
        [self alert:@"Secret invalid"];
        return;
    }
    if (stringIsEmpty(_key1Field.text)) {
        [self alert:@"Key 1 invalid"];
        return;
    }
    if (stringIsEmpty(_key2Field.text)) {
        [self alert:@"Key 2 invalid"];
        return;
    }
    if (stringIsEmpty(_wheelField.text)) {
        [self alert:@"Upper letter invalid"];
        return;
    }
    if (stringIsEmpty(_initialField.text)) {
        [self alert:@"Initial invalid"];
        return;
    }
    _option.initialized = YES;
    _option.protect = _protectSwitch.isOn;
    _option.password = _passwordField.text;
    _option.secret = _secretField.text;
    _option.key1 = _key1Field.text;
    _option.key2 = _key2Field.text;
    _option.wheel = _wheelField.text;
    _option.initial = _initialField.text;
    
    [[AppContext instance] persist];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onHelpClick:(id)sender {
    [self pushViewController:[HelpController class]];
}

@end
