//
//  JYTStrutsProblemViewController.m
//  iOSSamples
//
//  Created by Eason Qian on 14-7-2.
//  Copyright (c) 2014年 jinyuntian. All rights reserved.
//

#import "JYTStrutsProblemViewController.h"

@interface JYTStrutsProblemViewController ()

@end

@implementation JYTStrutsProblemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
