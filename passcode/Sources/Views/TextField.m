//
//  TextField.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextField.h"

#define HEDGE            4
#define VEDGE            2

@implementation TextField

- (void)awakeFromNib {
    self.borderStyle = UITextBorderStyleNone;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.edgeInsets = UIEdgeInsetsMake(VEDGE, HEDGE, VEDGE, HEDGE);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

@end
