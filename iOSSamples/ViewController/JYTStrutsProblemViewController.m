//
//  JYTStrutsProblemViewController.m
//  iOSSamples
//
//  Created by Eason Qian on 14-7-2.
//  Copyright (c) 2014年 jinyuntian. All rights reserved.
//

#import "JYTStrutsProblemViewController.h"

@interface JYTStrutsProblemViewController (){
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    IBOutlet UIView *view3;

}

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
}

-(void)viewDidLayoutSubviews{
    
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.view.frame = CGRectMake(0, 64, 320, 568);
//    }];
//    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [self.view bringSubviewToFront:redView];
    
//    self.view.frame = CGRectMake(0, 64, 320, 568);
    
    //view1.frame = CGRectMake(0, 100, 100, 100);
//   self.view.frame = CGRectMake(0, 64, 320, 568);
    
    
//    view1.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
