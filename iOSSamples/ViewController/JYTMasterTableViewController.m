//
//  JYTMasterTableViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/2/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTMasterTableViewController.h"

#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClassPrefix @"prefix"


@interface JYTMasterTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation JYTMasterTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addRedUIView];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    //self.navigationController.navigationBar.translucent = NO;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    
}

-(void)addRedUIView{
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //[[[[UIApplication sharedApplication] delegate] window] addSubview:redView];
}

-(void)initData{
    
//    self.tableView = [self itemsTable];
    
    self.items = @[
                   
                   @{kItemKeyTitle: @"PulseHalo",
                     kItemKeyDescription :@"波纹光环动画",
                     kItemKeyClassPrefix:@"JYTPulseHalo",
                   },
                   
                   @{kItemKeyTitle: @"ShakeAwardTurnTable",
                     kItemKeyDescription :@"摇奖转盘动画",
                     kItemKeyClassPrefix:@"JYTShakeAwardTurnTable",
                     },
                   
                   @{kItemKeyTitle: @"SectorView",
                     kItemKeyDescription :@"扇形的视图",
                     kItemKeyClassPrefix:@"JYTSector",
                     },
                   
                   @{kItemKeyTitle: @"JYTCGContextRefView",
                     kItemKeyDescription :@"CGContextRef画各种试图",
                     kItemKeyClassPrefix:@"JYTCGContextRef",
                     },
                   @{kItemKeyTitle: @"JYTCoinTransitionView",
                     kItemKeyDescription :@"硬币翻转",
                     kItemKeyClassPrefix:@"JYTCoinTransition",
                     },
                   
                   @{kItemKeyTitle: @"JYTFrameTestView",
                     kItemKeyDescription :@"UIView属性测试",
                     kItemKeyClassPrefix:@"JYTFrameTest",
                     },
                   @{kItemKeyTitle: @"JYTMoveToTrashView",
                     kItemKeyDescription :@"移动垃圾桶动画",
                     kItemKeyClassPrefix:@"JYTMoveToTrash",
                     },
                   
                   @{kItemKeyTitle: @"JYTAutoFitLableTextSIzeView",
                     kItemKeyDescription :@"AutoFitLable属性测试",
                     kItemKeyClassPrefix:@"JYTAutoFitLableTextSIze",
                     },
                   @{kItemKeyTitle: @"JYTLoadingView",
                     kItemKeyDescription :@"LoadingView单例模式",
                     kItemKeyClassPrefix:@"JYTLoading",
                     },
                   @{kItemKeyTitle: @"JYTStrutsProblemView",
                     kItemKeyDescription :@"不用autolayout处理不了的问题",
                     kItemKeyClassPrefix:@"JYTStrutsProblem",
                     },
                   
                   @{kItemKeyTitle: @"JYTTabBarView",
                     kItemKeyDescription :@"LoadingView单例模式",
                     kItemKeyClassPrefix:@"JYTTabBar",
                     },
                   @{kItemKeyTitle: @"JYTMemoryManagerView",
                     kItemKeyDescription :@"内存管理语义",
                     kItemKeyClassPrefix:@"JYTMemoryManager",
                     },
                   @{kItemKeyTitle: @"JYTBlockTestView",
                     kItemKeyDescription :@"block",
                     kItemKeyClassPrefix:@"JYTBlockTest",
                     },
                   @{kItemKeyTitle: @"JYTTouchTestView",
                     kItemKeyDescription :@"Touch Event",
                     kItemKeyClassPrefix:@"JYTTouchTest",
                     },
                   @{kItemKeyTitle: @"JYTOperationQueueTableView",
                        kItemKeyDescription :@"NSOperationQueue",
                        kItemKeyClassPrefix:@"JYTOperationQueueTable",
                        },
                   @{kItemKeyTitle: @"JYTOperationQueue2TableView",
                     kItemKeyDescription :@"NSOperationQueue2",
                     kItemKeyClassPrefix:@"JYTOperationQueue2Table",
                     },
                   @{kItemKeyTitle: @"JYTAutoLayoutView",
                     kItemKeyDescription :@"Autolayout code",
                     kItemKeyClassPrefix:@"JYTAutoLayout",
                     }
                   
                  ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                                   green:153./255.
                                                    blue:204./255.
                                                   alpha:1.0];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    NSDictionary *info = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = info[kItemKeyTitle];
    cell.detailTextLabel.text = info[kItemKeyDescription];
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = self.items[indexPath.row];
    NSString *className = [item[kItemKeyClassPrefix] stringByAppendingString:@"ViewController"];
    
    if (NSClassFromString(className)) {
        
        Class aClass = NSClassFromString(className);
        id instance = [[aClass alloc] init];
        
        if ([instance isKindOfClass:[UIViewController class]]) {
            
            [(UIViewController *)instance setTitle:item[kItemKeyTitle]];
            [self.navigationController pushViewController:(UIViewController *)instance
                                                 animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
