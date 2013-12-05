//
//  Button.h
//  passcode
//
//  Created by Fengxiang Xing on 9/28/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button : UIView {
    UIImageView *_iconImageView;
    UILabel *_textLabel;
}
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *disabledColor;
@property (nonatomic, strong) UIColor *highlightedColor;

- (void)setIcon:(UIImage *)icon;
- (void)setText:(NSString *)text;
- (void)layout;

@end
