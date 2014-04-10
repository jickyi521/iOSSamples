//
//  JYTCoinTransitionViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/9/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTCoinTransitionViewController.h"

@interface JYTCoinTransitionViewController ()

@end

@implementation JYTCoinTransitionViewController

@synthesize coinView;
@synthesize primaryView;

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
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIImageView *profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"profile.png"]];
    
    [coinView setPrimaryView: primaryView];
    [coinView setSecondaryView: profileView];
    [coinView setSpinTime:1.0];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
