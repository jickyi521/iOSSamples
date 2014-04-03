//
//  JYTSectorViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/3/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTSectorViewController.h"

// Rosette
#import "AURosetteView.h"
#import "AURosetteItem.h"

@interface JYTSectorViewController ()

- (void)twitterAction:(id)sender;
- (void)facebookAction:(id)sender;
- (void)mailAction:(id)sender;

@end

@implementation JYTSectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImage* twitterImage = [UIImage imageNamed:@"rosetta_twitter.png"];
    UIImage* facebookImage = [UIImage imageNamed:@"rosetta_facebook.png"];
    UIImage* mailImage = [UIImage imageNamed:@"rosetta_mail.png"];
    
    
    // create rosette items
    AURosetteItem* twitterItem = [[AURosetteItem alloc] initWithNormalImage:twitterImage
                                                           highlightedImage:nil
                                                                     target:self
                                                                     action:@selector(twitterAction:)];
    
    AURosetteItem* facebookItem = [[AURosetteItem alloc] initWithNormalImage:facebookImage
                                                            highlightedImage:nil
                                                                      target:self
                                                                      action:@selector(facebookAction:)];
    
    AURosetteItem* mailItem = [[AURosetteItem alloc] initWithNormalImage:mailImage
                                                        highlightedImage:nil
                                                                  target:self
                                                                  action:@selector(mailAction:)];
    
    // create rosette view
    AURosetteView* rosette = [[AURosetteView alloc] initWithItems: [NSArray arrayWithObjects: twitterItem, facebookItem, mailItem, nil]];
    
    rosette.center = self.view.center;
    //[rosette setCenter:CGPointMake(100.0f, 100.0f)];
    [self.view addSubview:rosette];
    
}

#pragma mark -
#pragma mark Actions

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)twitterAction:(id)sender {
    NSLog(@"Twitter");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)facebookAction:(id)sender {
    NSLog(@"Facebook");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mailAction:(id)sender {
    NSLog(@"Mail");
}

@end

