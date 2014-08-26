//
//  JYTBlockTestViewController.m
//  iOSSamples
//
//  Created by EasonQian on 8/13/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTBlockTestViewController.h"

@interface JYTBlockTestViewController ()

@end

@implementation JYTBlockTestViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


typedef void (^Block3)();

- (void)testBlock
{
    //_NSConcreteGlobalBlock
    NSMutableArray *array = [NSMutableArray array];
    addBlock(array);
    void (^block)() = array[0];
    block();
    
    int d = 5;
    void (^block2)() = ^(){
        printf("%d\n", d);
    };
    block2();
    
    Block3 block3 = ^(){
        NSLog(@"block3");
    };
    block3();
}


void addBlock(NSMutableArray *array) {
    [array addObject:^{
        printf("global block\n");
    }];
}

@end
