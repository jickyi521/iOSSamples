//
//  JYTImageDownloader.h
//  iOSSamples
//
//  Created by EasonQian on 8/27/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYTPhotoRecord;
// 2
@protocol ImageDownloaderDelegate;

@interface JYTImageDownloader : NSOperation

@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

// 3
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) JYTPhotoRecord *photoRecord;

// 4
- (id)initWithPhotoRecord:(JYTPhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>) theDelegate;

@end

@protocol ImageDownloaderDelegate <NSObject>

// 5
- (void)imageDownloaderDidFinish:(JYTImageDownloader *)downloader;

@end
