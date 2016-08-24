//
//  CHBTopicViewController.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/8/17.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBTopicViewController.h"
#import "CHBAllController.h"
#import <AFNetworking.h>
#import "CHBNewController.h"
#import "CHBTopic.h"
#import <SDImageCache.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "CHBTopicCell.h"
#import <MJRefresh.h>
@interface CHBTopicViewController ()
/** 下拉刷新控件 */
@property (weak,nonatomic)UIView *headView;
/** 上拉加载控件 */
@property (weak,nonatomic)UIView *footView;
/** 下拉lable */
@property (weak,nonatomic)UILabel *headLable;
/** 上拉lable */
@property (weak,nonatomic)UILabel *footLable;
/** 上拉加载标志位 */
@property (assign,nonatomic,getter=isRefresing)BOOL refresing;
/** 上拉加载标志位 */
@property (assign,nonatomic,getter=isLoadingMore)BOOL loadingMore;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 更多数据 */
@property (strong,nonatomic)NSMutableArray *moreTopics;
/** 最大帖子id */
@property (strong,nonatomic)NSString *maxtime;
/** afn管理者 */
@property (weak,nonatomic)AFHTTPSessionManager *manager;


@end

@implementation CHBTopicViewController
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    // 注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CHBTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CHBTopicCellId];
    self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 49, 0);
   
    self.tableView.backgroundColor = CHBCommonColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupRefresh) name:CHBRepeatClickTitleButtonNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupRefresh) name:CHBRepeatClickTabBarButtonNotification object:nil];
}
#pragma mark - 加载更多
-(void)loadMore{
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.paragma;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type); 
    parameters[@"maxtime"] = self.maxtime;
    // 3.发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *moreTopics = [CHBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 累加到旧数组的后面
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"load网络繁忙，请稍后再试！"];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(void)refreshData{
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.paragma;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.topics = [CHBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"refresh网络繁忙，请稍后再试！"];
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - 设置刷新控件
-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_header.automaticallyChangeAlpha=YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
-(NSString *)paragma{
    return [self.parentViewController isKindOfClass:[CHBNewController class]] ? @"newlist" : @"list";
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden= !self.topics.count;
    return self.topics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CHBTopicCellId];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
#pragma mark - cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHBTopic *topic = self.topics[indexPath.row];
    return  topic.cellHeight;
}
@end
