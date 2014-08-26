//
//  JYTMemoryManagerViewController.m
//  iOSSamples
//
//  Created by EasonQian on 8/5/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTMemoryManagerViewController.h"

@interface JYTMemoryManagerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (assign, nonatomic) CGRect assignTest;
@property (strong, nonatomic) NSString *strongTest;
@property (weak, nonatomic) NSString *weakTest;
@property (copy, nonatomic) NSString *copyaTest;



@end

@implementation JYTMemoryManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:@"strongTest" options:NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setStrongTest:(NSString *)strongTest
{
//    [_strongTest release];
//    [strongTest retain];
//    self.strongTest = strongTest;
}

- (void)setWeakTest:(NSString *)weakTest
{
    self.weakTest = weakTest;
}

- (void)setCopyTest:(NSString *)copyTest
{
    
}

- (IBAction)changeStringTest:(id)sender
{
    _contentLable.text = @"change";
    _strongTest = @"test";
    self.strongTest = @"test2";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    _contentLable.text = change.description;
}

@end
