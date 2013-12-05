//
//  AppDelegate.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <BugSense-iOS/BugSenseController.h>
#import "AppDelegate.h"

#import "LoginController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self preBootstrap];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.navigationController = [self createRootController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    [self postBootstrap];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (UINavigationController*)createRootController {
    LoginController *loginController = [[LoginController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    navigationController.navigationBarHidden = YES;
    return navigationController;
}

- (void)preBootstrap {
    [self initLogger];
    [self initContext];
}

- (void)postBootstrap {
    [self initCrashReporter];
}

- (void)initContext {
    [[AppContext instance] load];
}

- (void)initLogger {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

- (void)initCrashReporter {
    [BugSenseController sharedControllerWithBugSenseAPIKey:BUGSENSE_KEY];
}


@end
