//
//  JYTOperationQueueTableViewController.h
//  iOSSamples
//
//  Created by EasonQian on 8/27/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

// 2
#define kDatasourceURLString @"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"

@interface JYTOperationQueueTableViewController : UITableViewController


@property (nonatomic, strong) NSDictionary *photos; // main data source of controller

@end
