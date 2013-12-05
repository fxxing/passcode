//
//  MainController.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "BaseController.h"
#import "Button.h"

@interface MainController : BaseController <UITextFieldDelegate> {
    IBOutlet UILabel *_hintLabel;
    IBOutlet UITextField *_codeField;
    IBOutlet UILabel *_passwordLabel;
    IBOutlet Button *_copyButton;
    
    Option *_option;
}

@end
