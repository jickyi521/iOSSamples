//
//  JYTNewsTableViewCell.m
//  iOSSamples
//
//  Created by EasonQian on 4/25/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTNewsTableViewCell.h"

@implementation JYTNewsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initNewsCell:(JYTNewsData *)news{
    
    [_acaterImageView setImage:[UIImage imageNamed:news.avaterImageName]];
     _userNameLableView.text = news.userName;
     _contentLableView.text = news.contentText;
    [_contentImageView setImage:[UIImage imageNamed:news.contentImageName]];
    
    [self updateContentLableHeight];
}


-(void)updateContentLableHeight{
    
    CGSize labelsize = [self contentLabelSize:_contentLableView.text];
    
    CGRect contentLabelFrame = _contentLableView.frame;
    CGRect frame = self.frame;
    
    CGFloat extraHeight = labelsize.height - contentLabelFrame.size.height;
    
    contentLabelFrame.size.height = labelsize.height + 10;
    
    frame.size.height = frame.size.height + extraHeight;
    
    _contentLableView.frame = contentLabelFrame;
    self.frame = frame;

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

@end
