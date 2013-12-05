//
//  BaseController.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "TitleView.h"

@interface BaseController : UIViewController {
    IBOutlet TitleView *_titleView;
}

- (void)initView;

- (void)pushViewController:(Class)controllerClass;
- (void)alert:(NSString *)message;
- (void)alert:(NSString *)title :(NSString*)message;

@end
