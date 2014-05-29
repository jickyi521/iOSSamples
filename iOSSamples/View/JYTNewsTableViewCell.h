//
//  JYTNewsTableViewCell.h
//  iOSSamples
//
//  Created by EasonQian on 4/25/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTNewsData.h"



@interface JYTNewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *acaterImageView;

@property (strong, nonatomic) IBOutlet UILabel *userNameLableView;

@property (strong, nonatomic) IBOutlet UILabel *contentLableView;

@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;

-(void) initNewsCell:(JYTNewsData *) news;
@end
