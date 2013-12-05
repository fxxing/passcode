//
//  Extension.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//


@interface NSObject (Extension)

- (id)loadViewOfClass:(Class)class;

@end


@interface UIView (Extension)

- (UIView *)findFirstResponder;

@end