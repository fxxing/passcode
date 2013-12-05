//
// Created by Fengxiang Xing on 9/28/13.
// Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TitleView.h"

#define PADDING     4


@implementation TitleView

- (void)awakeFromNib {
    if (_backImageView) return;
    
    [super awakeFromNib];

    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 24)];
    _backImageView.image = [UIImage imageNamed:I(@"icon_back")];
    [self addSubview:_backImageView];

    self.color = [UIColor clearColor];
    self.disabledColor = [UIColor clearColor];
    self.highlightedColor = [UIColor orangeColor];
}

- (void)setBackEnabled:(BOOL)backEnabled {
    _backEnabled = backEnabled;
}

- (void)layout {
    CGFloat x = PADDING;
    if (_backEnabled) {
        _backImageView.hidden = NO;
        _backImageView.frame = CGRectMake(x, 8, 12, 24);
        x += _backImageView.frame.size.width;
        
    } else {
        _backImageView.hidden = YES;
    }
    
    if (_iconImageView.image) {
        _iconImageView.hidden = NO;
        _iconImageView.frame = CGRectMake(x, 8, 24, 24);
        x += _iconImageView.frame.size.width + PADDING;
        
    } else {
        _iconImageView.hidden = YES;
    }
    
    CGRect rect = _textLabel.frame;
    CGSize constraint = CGSizeMake(MAXFLOAT, rect.size.height);
    CGSize size = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:constraint lineBreakMode:_textLabel.lineBreakMode];
    rect.origin.x = x;
    rect.size.width = size.width;
    _textLabel.frame = rect;
    
    rect.origin.x = 0;
    rect.size.width = x + size.width + PADDING;
    
    self.frame = rect;
}

@end