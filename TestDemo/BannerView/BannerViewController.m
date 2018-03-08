//
//  BannerViewController.m
//  TestDemo
//
//  Created by vane on 08/03/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import "BannerViewController.h"
#import "UIImageView+WebCache.h"
#import "ZYBannerView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kNavigationBarHeight  64.0
#define kBannerHeight 192.0

@interface BannerViewController () <ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBanner];
}

- (void)setupBanner
{
    // 初始化
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    
    //config
    self.banner.shouldLoop = YES;
    self.banner.autoScroll = YES;
    self.banner.scrollInterval = 3.0;
    
    [self.view addSubview:self.banner];
    
    // 设置frame
    self.banner.frame = CGRectMake(0,
                                   kNavigationBarHeight,
                                   kScreenWidth,
                                   kBannerHeight);
}

#pragma mark - ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.dataArray.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的view, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
//    imageView.image = [UIImage imageNamed:imageName];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];

    return imageView;
}

// 返回 Footer 在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个项目", (long)index);
}

- (void)banner:(ZYBannerView *)banner didScrollToItemAtIndex:(NSInteger)index
{
    NSLog(@"滚动到第%ld个项目", (long)index);
}

// 在这里实现拖动 Footer 后的事件处理
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner
{
    NSLog(@"触发了footer");
    
//    NextViewController *vc = [[NextViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
//        _dataArray = @[@"ad_0.jpg", @"ad_1.jpg", @"ad_2.jpg"];
        _dataArray = @[@"http://7xk68o.com1.z0.glb.clouddn.com/1.jpg",
                       @"http://7xk68o.com1.z0.glb.clouddn.com/2.jpg",
                       @"http://7xk68o.com1.z0.glb.clouddn.com/3.jpg",
                       @"http://7xk68o.com1.z0.glb.clouddn.com/4.jpg",
                       @"http://7xk68o.com1.z0.glb.clouddn.com/5.jpg",
                       ];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
