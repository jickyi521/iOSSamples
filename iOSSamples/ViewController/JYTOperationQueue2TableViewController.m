//
//  JYTOperationQueue2TableViewController.m
//  iOSSamples
//
//  Created by EasonQian on 8/27/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTOperationQueue2TableViewController.h"
#import "JYTPhotoRecord.h"
#import "JYTPendingOperations.h"
#import "JYTImageDownloader.h"
#import "JYTImageFiltration.h"
#import "AFNetworking.h"

#define kDatasourceURLString @"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"

@interface JYTOperationQueue2TableViewController ()<ImageDownloaderDelegate, ImageFiltrationDelegate>

// 4
@property (nonatomic, strong) NSMutableArray *photos; // main data source of controller

// 5
@property (nonatomic, strong) JYTPendingOperations *pendingOperations;

@end

@implementation JYTOperationQueue2TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JYTPendingOperations *)pendingOperations {
    if (!_pendingOperations) {
        _pendingOperations = [[JYTPendingOperations alloc] init];
    }
    return _pendingOperations;
}

- (NSMutableArray *)photos {
    
    if (!_photos) {
        
        // 1
        NSURL *datasourceURL = [NSURL URLWithString:kDatasourceURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:datasourceURL];
        
        // 2
        AFHTTPRequestOperation *datasource_download_operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        // 3
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
//        [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//        [connection start];
        
        // 4
        [datasource_download_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 5
            NSData *datasource_data = (NSData *)responseObject;
            CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)datasource_data, kCFPropertyListImmutable, NULL);
            
            NSDictionary *datasource_dictionary = (__bridge NSDictionary *)plist;
            
            // 6
            NSMutableArray *records = [NSMutableArray array];
            
            for (NSString *key in datasource_dictionary) {
                JYTPhotoRecord *record = [[JYTPhotoRecord alloc] init];
                record.URL = [NSURL URLWithString:[datasource_dictionary objectForKey:key]];
                record.name = key;
                [records addObject:record];
                record = nil;
            }
            
            // 7
            self.photos = records;
            
            CFRelease(plist);
            
            [self.tableView reloadData];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            // 8
            // Connection error message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            alert = nil;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
        
        // 9
        [self.pendingOperations.downloadQueue addOperation:datasource_download_operation];
    }
    return _photos;
}

- (void)startOperationsForPhotoRecord:(JYTPhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath {
    
    // 2
    if (!record.hasImage) {
        [self startImageDownloadingForRecord:record atIndexPath:indexPath];
        
    }
    
    if (!record.isFiltered) {
        [self startImageFiltrationForRecord:record atIndexPath:indexPath];
    }
}

- (void)startImageDownloadingForRecord:(JYTPhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath {
    // 1
    if (![self.pendingOperations.downloadsInProgress.allKeys containsObject:indexPath]) {
        
        // 2
        // Start downloading
        JYTImageDownloader *imageDownloader = [[JYTImageDownloader alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:indexPath];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
}

- (void)startImageFiltrationForRecord:(JYTPhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath {
    // 3
    if (![self.pendingOperations.filtrationsInProgress.allKeys containsObject:indexPath]) {
        
        // 4
        // Start filtration
        JYTImageFiltration *imageFiltration = [[JYTImageFiltration alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        
        // 5
        JYTImageDownloader *dependency = [self.pendingOperations.downloadsInProgress objectForKey:indexPath];
        if (dependency)
            [imageFiltration addDependency:dependency];
        
        [self.pendingOperations.filtrationsInProgress setObject:imageFiltration forKey:indexPath];
        [self.pendingOperations.filtrationQueue addOperation:imageFiltration];
    }
}

- (void)imageDownloaderDidFinish:(JYTImageDownloader *)downloader {
    
    // 1
    NSIndexPath *indexPath = downloader.indexPathInTableView;
    // 2
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    // 3
    [self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];
}

- (void)imageFiltrationDidFinish:(JYTImageFiltration *)filtration {
    
    NSIndexPath *indexPath = filtration.indexPathInTableView;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.pendingOperations.filtrationsInProgress removeObjectForKey:indexPath];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 1
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = activityIndicatorView;
        
    }
    
    // 2
    JYTPhotoRecord *aRecord = [self.photos objectAtIndex:indexPath.row];
    
    // 3
    if (aRecord.hasImage) {
        
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = aRecord.image;
        cell.textLabel.text = aRecord.name;
        
    }
    // 4
    else if (aRecord.isFailed) {
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Failed.png"];
        cell.textLabel.text = @"Failed to load";
        
    }
    // 5
    else {
        
        [((UIActivityIndicatorView *)cell.accessoryView) startAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.textLabel.text = @"";
        
        if(!tableView.dragging && !tableView.decelerating){
            [self startOperationsForPhotoRecord:aRecord atIndexPath:indexPath];
        }
    }
    
    return cell;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 1
    [self suspendAllOperations];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 2
    if (!decelerate) {
        [self loadImagesForOnscreenCells];
        [self resumeAllOperations];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 3
    [self loadImagesForOnscreenCells];
    [self resumeAllOperations];
}

#pragma mark - Cancelling, suspending, resuming queues / operations

- (void)suspendAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:YES];
    [self.pendingOperations.filtrationQueue setSuspended:YES];
}

- (void)resumeAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:NO];
    [self.pendingOperations.filtrationQueue setSuspended:NO];
}

- (void)cancelAllOperations {
    [self.pendingOperations.downloadQueue cancelAllOperations];
    [self.pendingOperations.filtrationQueue cancelAllOperations];
}

- (void)loadImagesForOnscreenCells {
    
    // 1
    NSSet *visibleRows = [NSSet setWithArray:[self.tableView indexPathsForVisibleRows]];
    
    // 2
    NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperations.downloadsInProgress allKeys]];
    [pendingOperations addObjectsFromArray:[self.pendingOperations.filtrationsInProgress allKeys]];
    
    NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
    NSMutableSet *toBeStarted = [visibleRows mutableCopy];
    
    // 3
    [toBeStarted minusSet:pendingOperations];
    // 4
    [toBeCancelled minusSet:visibleRows];
    
    // 5
    for (NSIndexPath *anIndexPath in toBeCancelled) {
        
        JYTImageDownloader *pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:anIndexPath];
        [pendingDownload cancel];
        [self.pendingOperations.downloadsInProgress removeObjectForKey:anIndexPath];
        
        JYTImageFiltration *pendingFiltration = [self.pendingOperations.filtrationsInProgress objectForKey:anIndexPath];
        [pendingFiltration cancel];
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:anIndexPath];
    }
    toBeCancelled = nil;
    
    // 6
    for (NSIndexPath *anIndexPath in toBeStarted) {
        
        JYTPhotoRecord *recordToProcess = [self.photos objectAtIndex:anIndexPath.row];
        [self startOperationsForPhotoRecord:recordToProcess atIndexPath:anIndexPath];
    }
    toBeStarted = nil;
    
}

@end
