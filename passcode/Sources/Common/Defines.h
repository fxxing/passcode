//
//  Defines.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define T(s)                            s
#define I(s)                            s

#define BUGSENSE_KEY                    @""  // FIXME
#define AES_KEY                         @""  // FIXME
#define OPTION_FILE                     @"passcode"



#define LETTER_LOWER                    @"abcdefghijklmnopqrstuvwxyz"
#define LETTER_UPPER                    @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define LETTER_DIGIT                    @"0123456789"
#define LETTER_SPECIAL                  @"!@#$%^&*()_+~-={}[]\\|;':\",./<>?"

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]