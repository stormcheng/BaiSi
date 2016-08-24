//
//  CHBGetBigViewController.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/8/15.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBGetBigViewController.h"
#import "CHBTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
@interface CHBGetBigViewController ()<UIScrollViewDelegate>
/** 保存按钮 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
/** 图片滚动视图 */
@property (weak,nonatomic)UIScrollView *scrollView;
/** 图片视图 */
@property (weak,nonatomic)UIImageView *imageView;
@end

@implementation CHBGetBigViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置UI
    [self setupUI];
}
-(void)setupUI{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    //设置scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    // 设置imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveBtn.enabled = YES;
    }];
    imageView.chb_width = scrollView.chb_width;
    imageView.chb_height = imageView.chb_width * self.topic.height / self.topic.width;
    imageView.chb_x = 0;
    if (imageView.chb_height > CHBScreenH) { // 超过一个屏幕
        imageView.chb_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.chb_height);
    } else {
        imageView.chb_center_y= scrollView.chb_height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片缩放
    CGFloat maxScale = self.topic.width / imageView.chb_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}
#pragma mark - 返回
-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
#pragma mark - 保存图片
- (IBAction)savePic {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status==PHAuthorizationStatusDenied) {
            [SVProgressHUD showErrorWithStatus:@"请打开授权开关"];
        }else if(status==PHAuthorizationStatusAuthorized){
            [self saveImageIntoAlbum];
        }else if(status==PHAuthorizationStatusRestricted){
            [SVProgressHUD showErrorWithStatus:@"无法保存图片"];
        }
    }];
}
- (void)saveImageIntoAlbum
{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}
- (PHAssetCollection *)createdCollection
{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
@end
