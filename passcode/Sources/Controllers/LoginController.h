//
//  LoginController.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "BaseController.h"
#import "Button.h"

@interface LoginController : BaseController <UITextFieldDelegate> {
    IBOutlet UILabel *_hintLabel;
    IBOutlet UITextField *_passwordField;
    IBOutlet Button *_loginButton;
}

@end
