//
//  switchViewController.m
//  switch
//
//  Created by lc on 13-12-14.
//  Copyright (c) 2013年 lc. All rights reserved.
//

#import "switchViewController.h"
#import "LCSwitch.h"

@interface switchViewController ()<LCSwitchDelegate>
{
    LCSwitch *s;
}

@end

@implementation switchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    s = [[LCSwitch alloc]initWithFrame:CGRectMake(10, 100, 60, 30)];
    s.tag = 100;
    [s setOn:YES];
    s.center = self.view.center;
//    s.tintColor = [UIColor whiteColor];
//    s.onTintColor = [UIColor greenColor];
    s.delegate = self;
    [self.view addSubview:s];
}

- (void)switchAction:(id)mySwitch
{
    NSLog(@"my switch");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
