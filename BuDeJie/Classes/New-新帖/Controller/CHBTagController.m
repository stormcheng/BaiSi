//
//  CHBTagController.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/20.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBTagController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CHBTagItem.h"
#import "CHBSubtagCell.h"
#import <SVProgressHUD.h>
@interface CHBTagController ()
@property (strong,nonatomic)NSArray *tagItems;
@property (weak,nonatomic)AFHTTPSessionManager *manager;

@end

@implementation CHBTagController
static NSString * const tagID = @"cell";
#pragma mark - lazy
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;

}
-(NSArray *)tagItems{
    if (_tagItems == nil) {
        _tagItems = [NSArray array];
    }
    return _tagItems;

}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
//    初始化设置
    [self setup];
//    请求数据
    [self getData];
    [SVProgressHUD showWithStatus:@"正在加载"];
}
#pragma mark -  初始化设置
-(void)setup{
    self.navigationItem.title = @"推荐列表";
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHBSubtagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
}
#pragma mark - 请求数据
-(void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"tag_recommend";
    dic[@"action"] = @"sub";
    dic[@"c"] = @"topic";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.tagItems = [CHBTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据错误"];
    }];
}
#pragma mark - viewWillDisappear
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    [SVProgressHUD dismiss];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CHBSubtagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID forIndexPath:indexPath];
    cell.item = self.tagItems[indexPath.row];
    return cell;
}


@end
