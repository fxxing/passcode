//
//  PasswordStrengthView.h
//  passcode
//
//  Created by Fengxiang Xing on 9/28/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#define LEVEL_BEST          4
#define LEVEL_STRONG        3
#define LEVEL_FAIR          2
#define LEVEL_WEAK          1
#define LEVEL_INVILID       0


@interface PasswordStrengthView : UIView {
    NSArray *_labels;
    NSArray *_segments;
    UIColor *_nonColor;
    int _level;
}

- (int)securityLevel;
- (void)update:(NSString*)password;

@end
