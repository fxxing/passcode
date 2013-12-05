//
//  Button.m
//  passcode
//
//  Created by Fengxiang Xing on 9/28/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "Button.h"

#define PADDING     4

@implementation Button

- (void)awakeFromNib {
    if (_textLabel) return;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_textLabel];
    
    _color = [UIColor greenColor];
    _disabledColor = [UIColor lightGrayColor];
    _highlightedColor = [UIColor orangeColor];
}

- (void)setIcon:(UIImage *)icon {
    _iconImageView.image = icon;
}

- (void)setText:(NSString *)text {
    _textLabel.text = text;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self updateColor];
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    _disabledColor = disabledColor;
    [self updateColor];
}

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
    [self updateColor];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    [self updateColor];
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [self updateColor];
}

- (void)updateColor {
    if (_enabled) {
        if (_highlighted) {
            self.backgroundColor = _highlightedColor;
        } else {
            self.backgroundColor = _color;
        }
    } else {
        self.backgroundColor = _disabledColor;
    }
}

- (void)layout {
    CGRect rect = _textLabel.frame;
    CGSize constraint = CGSizeMake(MAXFLOAT, rect.size.height);
    CGSize size = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:constraint lineBreakMode:_textLabel.lineBreakMode];
    rect.origin.x = (self.bounds.size.width - size.width) / 2;
    rect.size.width = size.width;
    _textLabel.frame = rect;
    
    if (_iconImageView.image) {
        _iconImageView.hidden = NO;
        _iconImageView.frame = CGRectMake(rect.origin.x - 24 - PADDING, 8, 24, 24);
    } else {
        _iconImageView.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_enabled) {
        [self setHighlighted:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_enabled) return;
    [self setHighlighted:NO];
    CGPoint point = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) {
        if (_target && _action && [_target respondsToSelector:_action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
        }
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setHighlighted:NO];
}

@end
