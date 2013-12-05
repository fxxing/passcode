//
//  PasswordStrengthView.m
//  passcode
//
//  Created by Fengxiang Xing on 9/28/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "PasswordStrengthView.h"

#define SEGMENT             5
#define PADDING             4

@interface StrengthSegment : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSString *text;

+ (id)segmentWithText:(NSString*)text color:(int)color textColor:(int)textColor;
@end


@implementation StrengthSegment
+ (id)segmentWithText:(NSString*)text color:(int)color textColor:(int)textColor {
    StrengthSegment *s = [[StrengthSegment alloc] init];
    s.text = text;
    s.color = UIColorFromRGB(color);
    s.textColor = UIColorFromRGB(textColor);
    return s;
}

@end

@implementation PasswordStrengthView

- (void)awakeFromNib {
    if (_segments) return;
    _nonColor = UIColorFromRGB(0xEEEEEE);
    _labels = [NSArray arrayWithObjects:
              [[UILabel alloc] init],
              [[UILabel alloc] init],
              [[UILabel alloc] init],
              [[UILabel alloc] init],
              [[UILabel alloc] init],
              nil];
    _segments = [NSArray arrayWithObjects:
              [StrengthSegment segmentWithText:T(@"Invalid") color:0xB3B3B3 textColor:0x000000],
              [StrengthSegment segmentWithText:T(@"Weak") color:0xFF4444 textColor:0xFFFFFF],
              [StrengthSegment segmentWithText:T(@"Fair") color:0xFFBB33 textColor:0xFFFFFF],
              [StrengthSegment segmentWithText:T(@"Strong") color:0x99CC00 textColor:0xFFFFFF],
              [StrengthSegment segmentWithText:T(@"Best") color:0x33B5E5 textColor:0xFFFFFF],
              nil];
    for (UILabel *label in _labels) {
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    [self update:@""];
}

- (void)layoutSubviews {
    CGFloat labelWith = (self.bounds.size.width - PADDING * (SEGMENT - 1)) / SEGMENT;
    CGRect rect = CGRectMake(0, 0, labelWith, self.bounds.size.height);
    for (UILabel *label in _labels) {
        label.frame = rect;
        label.frame = CGRectIntegral(rect);
        rect.origin.x += labelWith + PADDING;
    }
}

- (void)update:(NSString*)password {
    _level = [self getPasswordSecurityLevel:password];
    for (int i=0;i<_labels.count;i++) {
        UILabel *label = [_labels objectAtIndex:i];
        StrengthSegment *segment = [_segments objectAtIndex:i];
        label.text = i == _level ? segment.text : @"";
        label.textColor = segment.textColor;
        label.backgroundColor = i <= _level ? segment.color : _nonColor;
    }
}

- (int)securityLevel {
    return _level;
}

- (int)getPasswordSecurityLevel:(NSString*)password {
    int score = [self getPasswordSecurityScore:password];
    if (score >= 80) return LEVEL_BEST;
    if (score >= 60) return LEVEL_STRONG;
    if (score >= 40) return LEVEL_FAIR;
    if (score > 0) return LEVEL_WEAK;
    return LEVEL_INVILID;
}

- (int)getPasswordSecurityScore:(NSString*)password {
    if (password.length < 6) return -1;
    int score = 0;
    
    BOOL hasLowerLetter = [self countChar:password inSet:LETTER_LOWER] > 0;
    BOOL hasUpperLetter = [self countChar:password inSet:LETTER_UPPER] > 0;
    int digitCount = [self countChar:password inSet:LETTER_DIGIT];
    int specialCount = [self countChar:password inSet:LETTER_SPECIAL];
    // length
    score += password.length <= 8 ? 5 : (password.length > 10 ? 25 : 10);
    // case
    score += hasLowerLetter ? (hasUpperLetter ? 20 : 10) : (hasUpperLetter ? 10 : 0);
    // number
    score += digitCount > 3 ? 20 : (digitCount == 0 ? 0 : 10);
    // special char
    score += specialCount > 1 ? 25 : (specialCount == 0 ? 0 : 10);
    // bounce
    if (digitCount > 0 && specialCount > 0) {
        if (hasLowerLetter && hasUpperLetter) {
            score += 5;
        } else if (hasLowerLetter || hasUpperLetter) {
            score += 3;
        }
    } else {
        if (digitCount > 0 && (hasLowerLetter || hasUpperLetter)) {
            score += 2;
        }
    }
    return score;
}

- (int)countChar:(NSString*)text inSet:(NSString*)set {
    int count = 0;
    for (int i=0;i<text.length;i++) {
        NSString *c = [text substringWithRange:NSMakeRange(i, 1)];
        if ([set rangeOfString:c].location != NSNotFound) {
            count ++;
        }
    }
    return count;
}

@end
