//
//  JYTShakeAwardTurnTableViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/3/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTShakeAwardTurnTableViewController.h"
#import "HHTurntableView.h"

@interface JYTShakeAwardTurnTableViewController ()

@end

@implementation JYTShakeAwardTurnTableViewController

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
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.png"]];
    
    HHTurntableView *turntableView = [[HHTurntableView alloc]initWithFrame:CGRectMake(0.0,0.0,300,300)];
    turntableView.center = self.view.center;
    [self.view addSubview:turntableView];
    
    UIImageView *imagePoint = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_point.png"]];
    imagePoint.center = CGPointMake(self.view.center.x, self.view.center.y -70);
    [self.view addSubview:imagePoint];
    
    UIImageView *imageTop = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_center.png"]];
    imageTop.center = self.view.center;
    [self.view addSubview:imageTop];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
