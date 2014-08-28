//
//  JYTOperationQueueTableViewController.m
//  iOSSamples
//
//  Created by EasonQian on 8/27/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTOperationQueueTableViewController.h"

@interface JYTOperationQueueTableViewController ()

@property (strong, nonatomic) NSOperationQueue *imageQueue;
@property (strong, nonatomic) NSMutableDictionary *dictImages;

@end

@implementation JYTOperationQueueTableViewController

@synthesize photos = _photos;
@synthesize imageQueue = _imageQueue;

- (void)viewDidLoad
{
    self.title = @"Classic Photos";
    
    // 4
    self.tableView.rowHeight = 80.0;
    [super viewDidLoad];
}

- (NSOperationQueue *)imageQueue
{
    if(!_imageQueue){
        _imageQueue = [[NSOperationQueue alloc] init];
        [_imageQueue setMaxConcurrentOperationCount:10];
    }
    return _imageQueue;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSDictionary *)photos
{
    if (!_photos) {
        
        NSBlockOperation *getPhotoBlock = [NSBlockOperation blockOperationWithBlock:^{
            NSURL *dataSourceURL = [NSURL URLWithString:kDatasourceURLString];
            _photos = [[NSDictionary alloc] initWithContentsOfURL:dataSourceURL];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }];
        
        [self.imageQueue addOperation:getPhotoBlock];
        
    }
    return _photos;
    
//    if (!_photos) {
//        _photos = [[NSDictionary alloc] init];
//        NSURL *dataSourceURL = [NSURL URLWithString:kDatasourceURLString];
//        
//        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//            _photos = [[NSDictionary alloc] initWithContentsOfURL:dataSourceURL];
//            _dictImages = [[NSMutableDictionary alloc] initWithDictionary:_photos];
//            
//            for(NSString *url in [_photos allKeys]){
//                
//                NSURL *imageURL = [NSURL URLWithString:[_photos objectForKey:url]];
//                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//                [_dictImages setValue:imageData forKey:url];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//                });
//            }
//            
//        }];
//        
//        [self.imageQueue addOperation:blockOperation];
//
//    }
//    
//    return _photos;
}

#pragma mark - UITableView data source and delegate methods

// 6
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.photos.count;
    return count;
}

// 7
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"Cell Identifier";
    __block UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __block NSIndexPath *path = indexPath;
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 8
        NSString *rowKey = [[self.photos allKeys] objectAtIndex:path.row];
        NSURL *imageURL = [NSURL URLWithString:[self.photos objectForKey:rowKey]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = nil;
        
        // 9
        if (imageData) {
            UIImage *unfiltered_image = [UIImage imageWithData:imageData];
            image = [self applySepiaFilterToImage:unfiltered_image];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.textLabel.text = [NSString stringWithFormat:@"%@ + %i", rowKey, path.row];
            cell.imageView.image = image;
        }];
        
    }];
    
    [self.imageQueue addOperation:blockOperation];
    
    return cell;
}

#pragma mark - Image filtration

// 10
- (UIImage *)applySepiaFilterToImage:(UIImage *)image {
    
    CIImage *inputImage = [CIImage imageWithData:UIImagePNGRepresentation(image)];
    UIImage *sepiaImage = nil;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
    CGImageRelease(outputImageRef);
    return sepiaImage;
}

@end
