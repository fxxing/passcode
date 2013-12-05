//
//  HelpController.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "HelpController.h"


@implementation HelpController


- (void)initView {
    [super initView];
    [_titleView setBackEnabled:YES];
    [_titleView setIcon:[UIImage imageNamed:I(@"icon_help")]];
    [_titleView setText:T(@"HELP")];
    [_titleView layout];
}

@end
