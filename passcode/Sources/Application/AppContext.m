//
//  AppContext.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "AppContext.h"
#import "JSONKit.h"
#import "FileUtils.h"


#define KEY_INITIALIZED     @"initialized"
#define KEY_PROTECT			@"protect"
#define KEY_PASSWORD		@"password"
#define KEY_SECRET			@"secret"
#define KEY_KEY1			@"key1"
#define KEY_KEY2			@"key2"
#define KEY_WHEEL			@"wheel"
#define KEY_INITIAL			@"initial"
@implementation AppContext

SINGLETON_IMPLEMENT(AppContext)

- (void)load {
    if (_option) return;
    _option = [[Option alloc] init];

    NSString *jsonString = read_file(OPTION_FILE, YES);
    if (jsonString) {
        NSDictionary *jsonData = [jsonString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
        
        _option.initialized = [[jsonData objectForKey:KEY_INITIALIZED] boolValue];
        _option.protect = [[jsonData objectForKey:KEY_PROTECT] boolValue];
        _option.password = [jsonData objectForKey:KEY_PASSWORD];
        _option.secret = [jsonData objectForKey:KEY_SECRET];
        _option.key1 = [jsonData objectForKey:KEY_KEY1];
        _option.key2 = [jsonData objectForKey:KEY_KEY2];
        _option.wheel = [jsonData objectForKey:KEY_WHEEL];
        _option.initial = [jsonData objectForKey:KEY_INITIAL];
    }
}

- (void)persist {
    NSMutableDictionary *jsonData = [[NSMutableDictionary alloc] init];
    
    [jsonData setObject:[NSNumber numberWithBool:_option.initialized] forKey:KEY_INITIALIZED];
    [jsonData setObject:[NSNumber numberWithBool:_option.protect] forKey:KEY_PROTECT];
    if (_option.password) [jsonData setObject:_option.password forKey:KEY_PASSWORD];
    if (_option.secret) [jsonData setObject:_option.secret forKey:KEY_SECRET];
    if (_option.key1) [jsonData setObject:_option.key1 forKey:KEY_KEY1];
    if (_option.key2) [jsonData setObject:_option.key2 forKey:KEY_KEY2];
    if (_option.wheel) [jsonData setObject:_option.wheel forKey:KEY_WHEEL];
    if (_option.initial) [jsonData setObject:_option.initial forKey:KEY_INITIAL];
    
    NSString *jsonString = [jsonData JSONStringWithOptions:JKParseOptionLooseUnicode error:nil];
    write_file(OPTION_FILE, jsonString, YES);
}

@end
