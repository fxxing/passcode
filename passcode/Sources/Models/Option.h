//
//  Option.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//


@interface Option : NSObject

@property (nonatomic, assign) BOOL initialized;
@property (nonatomic, assign) BOOL protect;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *key1;
@property (nonatomic, strong) NSString *key2;
@property (nonatomic, strong) NSString *wheel;
@property (nonatomic, strong) NSString *initial;

@end
