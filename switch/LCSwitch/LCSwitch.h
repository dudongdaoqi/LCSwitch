//
//  Switch.h
//  switch
//
//  Created by lc on 13-12-14.
//  Copyright (c) 2013年 lc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCSwitchDelegate <NSObject>

- (void)switchAction:(id)mySwitch;

@end


@interface LCSwitch : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, retain) UIColor *onTintColor;
@property (nonatomic, getter=isOn) BOOL On;
@property (nonatomic, assign) id<LCSwitchDelegate>delegate;

- (id)initWithFrame:(CGRect)frame;
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
