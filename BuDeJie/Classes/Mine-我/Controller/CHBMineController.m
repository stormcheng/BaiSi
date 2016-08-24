//
//  CHBMineController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBMineController.h"
#import "CHBSettingController.h"
#import "CHBCollectionViewCell.h"
#import "CHBCollectionItem.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#define margin  1
#define iconWidth (self.view.chb_width - (margin * 4))/4
@interface CHBMineController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) CHBSettingController *settingController;
@property (strong,nonatomic)NSArray *collectionItems;
@property (strong,nonatomic)UICollectionView *collectionView;

@end

@implementation CHBMineController
static NSString * const collID = @"coll";
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
#pragma mark - lazy
-(CHBSettingController *)settingController{
    if (_settingController == nil) {
        _settingController = [[CHBSettingController alloc]init];
    }
    return _settingController;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏 */
    [self setupNav];
    /** 设置底部视图 */
    [self setupFooterView];
    /** 载入数据 */
    [self loadData];
    self.tableView.sectionHeaderHeight = 0 ;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}
#pragma mark -  设置底部视图
-(void)setupFooterView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    layout.itemSize = CGSizeMake(iconWidth,90);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 800) collectionViewLayout:layout];
    collectionView.backgroundColor = CHBCommonColor;
    self.tableView.tableFooterView = self.collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"CHBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collID];
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.tableView.tableFooterView = collectionView;
    self.collectionView= collectionView;
}
#pragma mark - 初始化导航栏
-(void)setupNav{
    //    设置标题view
    self.navigationItem.title = @"我";
    //    设置右边边按钮
    UIBarButtonItem *setting = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"mine-setting-icon"]  andHighlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] andTarget:self andSelector:@selector(setting)];
    UIBarButtonItem *moon = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"mine-moon-icon"]    andSelectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] andTarget:self andSelector:@selector(nightMode:)];
    self.navigationItem.rightBarButtonItems = @[setting,moon];
}
#pragma mark - setting
-(void)setting{
    self.settingController.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:self.settingController animated:YES];
}
#pragma mark - 夜间模式
-(void)nightMode:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - loadData
-(void)loadData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"]=@"square";
    dic[@"c"]=@"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        self.collectionItems = [CHBCollectionItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        NSInteger row = (self.collectionItems.count - 1) / 4 + 1;
        self.collectionView.chb_height  = row * (90 +margin);
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHBFunc
    }];
}
#pragma mark - collectionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collID forIndexPath:indexPath];
    cell.item = self.collectionItems[indexPath.row];
    return cell;
}
@end
