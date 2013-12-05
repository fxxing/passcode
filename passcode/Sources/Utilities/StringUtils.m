//
//  StringUtils.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "StringUtils.h"

BOOL stringIsEmpty(NSString *string) {
    return string == nil || [string isEqualToString:@""];
}