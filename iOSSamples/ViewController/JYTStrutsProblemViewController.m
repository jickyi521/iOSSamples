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

    IBOutlet UIButton *middleView;
    
    IBOutlet UIButton *rightButtonView;
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
    
    self.navigationController.navigationBarHidden = YES;
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(middleView, rightButtonView);
    [NSLayoutConstraint constraintsWithVisualFormat:@"[middleView(70)]-20-[rightButtonView(70)]" options:0 metrics:nil views:viewDictionary];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewDidLayoutSubviews{
    
    
    
//    middleView.frame = CGRectMake(middleView.frame.origin.x, middleView.frame.origin.y, CGRectGetWidth(middleView.frame), CGRectGetHeight(middleView.frame) + 100);
    
    
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.view.frame = CGRectMake(0, 64, 320, 568);
//    }];
//    
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    [self.view bringSubviewToFront:redView];
    
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

- (IBAction)view1Click:(id)sender
{
    //[middleView removeFromSuperview];
    middleView.frame = CGRectMake(middleView.frame.origin.x, middleView.frame.origin.y, CGRectGetWidth(middleView.frame), 100);
    //middleView.frame.size = CGSizeMake(CGRectGetWidth(middleView.frame), CGRectGetHeight(middleView.frame) + 50);
}

@end
