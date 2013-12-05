//
//  OptionController.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "BaseController.h"
#import "PasswordStrengthView.h"

@interface OptionController : BaseController {
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIView *_contentView;
    
    IBOutlet UISwitch *_protectSwitch;
    IBOutlet UITextField *_passwordField;
    IBOutlet UITextField *_secretField;
    IBOutlet UITextField *_key1Field;
    IBOutlet UITextField *_key2Field;
    IBOutlet UITextField *_wheelField;
    IBOutlet UITextField *_initialField;
    
    IBOutlet PasswordStrengthView *_passwordStrengthView;
    Option *_option;
    
    BOOL _keyboardShown;
}

@end
