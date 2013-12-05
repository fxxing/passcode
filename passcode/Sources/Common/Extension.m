//
//  Extension.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//


@implementation NSObject (Extension)

- (id)loadViewOfClass:(Class)class; {
    @try {
        NSArray *nibs =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(class) owner:nil options:nil];
        for (id nib in nibs) {
            if ([nib isKindOfClass:class]) {
                return nib;
            }
        }
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end


@implementation UIView (Extension)

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

@end