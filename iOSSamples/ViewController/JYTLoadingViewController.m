//
//  JYTLoadingViewController.m
//  iOSSamples
//
//  Created by EasonQian on 5/28/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTLoadingViewController.h"
#import "JYTloadingVIew.h"

@interface JYTLoadingViewController ()

@end

@implementation JYTLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"JYTLoadingViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickButton:(UIButton *)button{
    switch (button.tag) {
        case 1:
            [[JYTLoadingView getShareInstance] show];
            break;
         case 2:
            [[JYTLoadingView getShareInstance] stop];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
