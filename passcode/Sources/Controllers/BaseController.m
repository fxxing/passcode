//
//  BaseController.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "BaseController.h"
#import "SIAlertView.h"

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [_titleView setEnabled:YES];
    [_titleView setTarget:self];
    [_titleView setAction:@selector(onTitleViewClick:)];
}

- (void)pushViewController:(Class)controllerClass {
    id controller = [[controllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Alerts
- (void)alert:(NSString *)message {
    [self alert:T(@"") :message];
}

- (void)alert:(NSString*)title :(NSString *)message {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeCancel handler:nil];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}

#pragma mark - Actions

- (void)onTitleViewClick:(TitleView*)sender {
    if (sender.backEnabled) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
