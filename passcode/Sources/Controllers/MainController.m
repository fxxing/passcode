//
//  MainController.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "MainController.h"
#import "OptionController.h"
#import "CryptUtils.h"

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _option = [AppContext instance].option;
    if (!_option.initialized) {
        [self pushViewController:[OptionController class]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_codeField becomeFirstResponder];
}

- (void)initView {
    [super initView];
    [_titleView setBackEnabled:YES];
    [_titleView setIcon:[UIImage imageNamed:I(@"icon_key")]];
    [_titleView setText:T(@"PASSCODE")];
    [_titleView layout];
    
    
    [_copyButton setEnabled:YES];
    [_copyButton setTarget:self];
    [_copyButton setAction:@selector(onCopyClick:)];
    [_copyButton setText:T(@"COPY")];
    [_copyButton layout];
}

- (void)update:(NSString*)code {
    NSString *code1 = hmac(_option.secret, code);
    NSString *code2 = hmac(code1, _option.key1);
    NSString *code3 = hmac(code1, _option.key2);
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i=0; i < 16; i++) {
        NSString *source = [code2 substringWithRange:NSMakeRange(i, 1)];
        if ([LETTER_LOWER rangeOfString:source].location != NSNotFound) {
            NSString *rule = [code3 substringWithRange:NSMakeRange(i, 1)];
            if ([_option.wheel rangeOfString:rule].location != NSNotFound) {
                source = [source uppercaseString];
            }
        }
        [result appendString:source];
    }
    if ([LETTER_DIGIT rangeOfString:[result substringWithRange:NSMakeRange(0, 1)]].location != NSNotFound) {
        _passwordLabel.text = [NSString stringWithFormat:@"%@%@", _option.initial, [result substringFromIndex:1]];
    } else {
        _passwordLabel.text = result;
    }
    
    [_copyButton setIcon:nil];
}

- (void)copyToPasteboard:(NSString*)text {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setValue:text forPasteboardType:(NSString *)kUTTypeText];
    [pasteboard setValue:text forPasteboardType:(NSString *)kUTTypeItem];
    [pasteboard setValue:text forPasteboardType:(NSString *)kUTTypeText];
    [pasteboard setValue:text forPasteboardType:(NSString *)kUTTypeUTF8PlainText];
    [pasteboard setValue:text forPasteboardType:@"public.plain-text"];
    [pasteboard setValue:text forPasteboardType:@"public.text"];
}

#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [_codeField.text stringByReplacingCharactersInRange:range withString:string];
    [self update:newText];
    return YES;
}

#pragma mark - Actions

- (IBAction)onOptionClick:(id)sender {
    [self pushViewController:[OptionController class]];
}

- (void)onCopyClick:(id)sender {
    [self copyToPasteboard:_passwordLabel.text];
    
    [_copyButton setIcon:[UIImage imageNamed:I(@"icon_check")]];
    [_copyButton layout];
}

@end
