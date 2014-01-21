//
//  Switch.m
//  switch
//
//  Created by lc on 13-12-14.
//  Copyright (c) 2013年 lc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LCSwitch.h"

#define kDefaultAnimationTime 0.15f
#define kBoardColor [[UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1.00f] CGColor]

@interface LCSwitch() 
{
    UIView *_onBtn;
    UILabel *_thumn;
    float _trackLength;
    float _end;
}

@end

@implementation LCSwitch

@synthesize On = _On;
@synthesize onTintColor = _onTintColor;
@synthesize delegate = _delegate;

- (void)dealloc
{
    [_onTintColor release];
    [_onBtn release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _On = NO;
        _onTintColor = [[UIColor alloc]initWithRed:0.20f green:0.42f blue:0.86f alpha:1.00f];
    

        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor greenColor];
        self.clipsToBounds = YES;
        
        self.layer.cornerRadius = CGRectGetHeight(frame) * 0.5;
        self.layer.borderColor = kBoardColor;
        self.layer.borderWidth = 1;
        
        // tap gesture for toggling the switch
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(didTap:)];
        [tapGesture setDelegate:self];
        [self addGestureRecognizer:tapGesture];
        
        
        // pan gesture for moving the switch knob manually
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(didDrag:)];
        [panGesture setDelegate:self];
        [self addGestureRecognizer:panGesture];

        
        _trackLength = CGRectGetWidth(frame) - CGRectGetHeight(frame);
        CGRect thumbRect = frame;
        thumbRect.origin.y = 0;
        if (self.isOn) {
           thumbRect.origin.x = CGRectGetWidth(frame) - CGRectGetHeight(frame);
        }else{
            thumbRect.origin.x = 0;
        }
        
        _onBtn = [[UIView alloc]initWithFrame:thumbRect];
        _onBtn.backgroundColor = [UIColor whiteColor];
        _onBtn.layer.CornerRadius = CGRectGetHeight(frame)*0.5;
        [self addSubview:_onBtn];
        
        CGRect labelRect = CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        UIView *round = [[UIView alloc]initWithFrame:labelRect];
        round.backgroundColor = [UIColor whiteColor];
        round.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
        round.layer.borderColor = [UIColor grayColor].CGColor;
        round.layer.borderWidth = 0.1;
        round.layer.shadowColor = [UIColor grayColor].CGColor;
        round.layer.shadowRadius = 2.0;
        round.layer.shadowOpacity = 0.5;
        round.layer.shadowOffset = CGSizeMake(0, 3);
        round.layer.masksToBounds = NO;
        [_onBtn addSubview:round];
        [round release];
    }
    return self;
}




-(void) didDrag:(UIPanGestureRecognizer*)gesture
{
    CGFloat translation = [gesture translationInView:_onBtn].x;
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        if (self.isOn)
        {
            if (translation > 0 || translation < -_trackLength)
            {
                return;
            }
        }
        else
        {
            if (translation < 0 || translation > _trackLength)
            {
                return;
            }
            
        }
        _onBtn.transform = CGAffineTransformMakeTranslation(_end+translation, 0);

	}
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
		_end =_onBtn.transform.tx;
        if (fabs(translation) >= _trackLength * 0.5)
        {
            [self change];
        }
        else
        {
            [self noChange];
        }
	}
}

-(void) didTap:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self change];
    }
}

- (void)change
{
    if (self.isOn) {
        [self setOn:NO animated:YES];
    }
    else{
        [self setOn:YES animated:YES];
    }

    if ([self.delegate respondsToSelector:@selector(switchAction:)]) {
        [self.delegate switchAction:self];
    }
}

- (void)noChange
{
    if (self.isOn) {
        [self setOn:YES animated:YES];
    }
    else{
        [self setOn:NO animated:YES];
    }
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    if (animated){
        [UIView animateWithDuration: kDefaultAnimationTime
                              delay: 0.05
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             if (on) {
                                 [self setX:_onBtn length:_trackLength];
                             }else{
                                 [self setXZero:_onBtn];
                             }
                         }
                         completion:^(BOOL finished){
                             _On = on;
                         }
         ];
    }
    else
    {
        if (on) {
            [self setX:_onBtn length:_trackLength];
        }else{
            [self setXZero:_onBtn];
        }
        _On = on;
    }
}

- (void)setX:(UIView *)sender length:(float)length
{
    CGRect rect = sender.frame;
    rect.origin.x = length;
    sender.frame = rect;
}

- (void)setXZero:(UIView *)sender
{
    CGRect rect = sender.frame;
    rect.origin.x = 0;
    sender.frame = rect;
}

- (void) setOn:(BOOL)on
{
    if (on) {
        [self setOn:YES animated:NO];
    }else{
        [self setOn:NO animated:NO];
    }
}
#pragma mark - set method

- (void)setOnTintColor:(UIColor*)onTintColor
{
    if (_onTintColor != onTintColor) {
        [_onTintColor release];
        _onTintColor = [onTintColor retain];
    }
    self.backgroundColor = _onTintColor;
}



@end
