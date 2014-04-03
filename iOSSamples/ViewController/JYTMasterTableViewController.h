//
//  JYTMasterTableViewController.h
//  iOSSamples
//
//  Created by EasonQian on 4/2/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYTMasterTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) IBOutlet UITableView *itemsTable;

@end
