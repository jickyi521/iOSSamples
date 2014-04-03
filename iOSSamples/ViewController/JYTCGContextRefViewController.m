//
//  JYTCGContextRefViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/3/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTCGContextRefViewController.h"
#import "JYTCGContextRefCustomerView.h"

@interface JYTCGContextRefViewController ()

@end

@implementation JYTCGContextRefViewController

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
    
    JYTCGContextRefCustomerView *customerView = [[JYTCGContextRefCustomerView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:customerView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
