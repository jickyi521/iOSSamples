//
//  JYTAutoFitLableTextSIzeViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/25/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTAutoFitLableTextSIzeViewController.h"
#import "JYTNewsTableViewCell.h"


@interface JYTAutoFitLableTextSIzeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *newsArray;

@end


@implementation JYTAutoFitLableTextSIzeViewController


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
    
    
    _newsArray = [NSMutableArray array];
    
    JYTNewsData *news = [[JYTNewsData alloc] init];
    news.avaterImageName = @"rosetta_twitter.png";
    news.userName = @"test";
    news.contentText = @"contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent";
    news.contentImageName = @"rosetta_facebook.png";
    
    for (int i = 0; i < 10; i++) {
       [_newsArray addObject:news];
    }
    
    
    // Do any additional setup after loading the view from its nib.
}


-(CGFloat)cellForHeight:(JYTNewsData *)news{
    CGFloat extraHeight = [self contentLabelSize:news.contentText].height - 21;
    
    return extraHeight;
}

- (CGSize)contentLabelSize:(NSString *)text
{
    CGSize size = CGSizeMake(160.0, 600.0);
    
    CGSize labelsize = [text sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:size];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.0], NSFontAttributeName, nil];
        CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        labelsize = frame.size;
    }
    
    labelsize.height = labelsize.height > 21 ? labelsize.height : 21;
    
    return labelsize;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"newscell";
    JYTNewsTableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JYTNewsTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell initNewsCell:_newsArray[indexPath.row]];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellForHeight:_newsArray[indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArray.count;
}

#pragma UITableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
