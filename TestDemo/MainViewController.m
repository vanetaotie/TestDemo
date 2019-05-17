//
//  MainViewController.m
//  TestDemo
//
//  Created by vane on 15/2/2.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkTest.h"
#import "FloatWindowViewController.h"
#import "EventKitTestViewController.h"
#import "CollectionTestViewController.h"
#import "PlayerViewController.h"
#import "KeyBoardViewController.h"
#import "DLAlertViewController.h"
#import "GAndATestViewController.h"
#import "LimitInputViewController.h"
#import "ScrollTextViewController.h"
#import "WebViewController.h"
#import "CutImageViewController.h"
#import "BannerViewController.h"
#import "HorizontalViewController.h"
#import "DLApi.h"
#import "UITabBar+Utility.h"
#import "SwipCollectionViewController.h"
#import "ZYTextInputViewController.h"
#import "PageViewDemoVC.h"

#import "DYLeftSlipManager.h"
#import "LeftTableViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *mainViewControllers;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.hidesBarsOnSwipe = YES;
    
    self.title = @"TestDemo";
    self.mainViewControllers = @[
                                 NSStringFromClass([NetworkTest class]),
                                 NSStringFromClass([FloatWindowViewController class]),
                                 NSStringFromClass([EventKitTestViewController class]),
                                 NSStringFromClass([CollectionTestViewController class]),
                                 NSStringFromClass([PlayerViewController class]),
                                 NSStringFromClass([KeyBoardViewController class]),
                                 NSStringFromClass([DLAlertViewController class]),
                                 NSStringFromClass([GAndATestViewController class]),
                                 NSStringFromClass([LimitInputViewController class]),
                                 NSStringFromClass([ScrollTextViewController class]),
                                 NSStringFromClass([WebViewController class]),
                                 NSStringFromClass([DLApi class]),
                                 NSStringFromClass([CutImageViewController class]),
                                 NSStringFromClass([BannerViewController class]),
                                 NSStringFromClass([HorizontalViewController class]),
                                 NSStringFromClass([SwipCollectionViewController class]),
                                 NSStringFromClass([ZYTextInputViewController class]),
                                 NSStringFromClass([PageViewDemoVC class])
                                 ];
    
    [self.view addSubview:self.mainTableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(clickTest)];
    [self navigationItem].rightBarButtonItem = rightItem;
    
//    [[DYLeftSlipManager sharedManager] setLeftViewController:[LeftTableViewController new] coverViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickTest {
    // 代码唤出左滑视图
    [[DYLeftSlipManager sharedManager] showLeftView];
}

#pragma mark - Getter & Setter

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
    }
    return _mainTableView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
    return _mainViewControllers[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mainViewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.textLabel.text = [self titleForCellAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcTitle = [self titleForCellAtIndexPath:indexPath];
    UIViewController *vc = nil;
    if ([vcTitle isEqualToString:NSStringFromClass([NetworkTest class])]) {
        NetworkTest *test = [[NetworkTest alloc] init];
        [test startNetworkTest];
        
    } else if ([vcTitle isEqualToString:NSStringFromClass([PlayerViewController class])]) {
#if (TARGET_IPHONE_SIMULATOR)
        return;
#else
        NSURL *videoUrl = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestFiles/test.mp4"]];
//        NSURL *videoUrl = [NSURL URLWithString:@"http://www.jxvdy.com/file/upload/201309/18/18-10-03-19-3.mp4"];
        PlayerViewController *playerVC = [[PlayerViewController alloc] initWithUrl:videoUrl];
        [playerVC showInViewController:self];
#endif
    } else if ([vcTitle isEqualToString:NSStringFromClass([KeyBoardViewController class])]) {
        KeyBoardViewController *keyBoardVC = [[KeyBoardViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:keyBoardVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    } else if ([vcTitle isEqualToString:NSStringFromClass([WebViewController class])]) {
        vc = [[WebViewController alloc] init];
//        [self testSelectorMethod];
        
    } else if ([vcTitle isEqualToString:NSStringFromClass([DLApi class])]) {
        [DLApi registerApp:@"123456"];
        DLApiObject *obj = [DLApiObject new];
        obj.appID = @"123456";
        obj.state = @"1221";
        [DLApi sendOAuthReq:obj];
        
    } else if ([vcTitle isEqualToString:NSStringFromClass([CutImageViewController class])]) {
        CutImageViewController *cutVC = [[CutImageViewController alloc] initWithOriginImage:[UIImage imageNamed:@"1"]];
        cutVC.cutSuccessBlock = ^(UIImage *cutImage) {
            UIImage *image = cutImage;
            NSLog(@"%@", image);
        };
        vc = cutVC;
    } else if ([vcTitle isEqualToString:NSStringFromClass([SwipCollectionViewController class])]) {
        
        // 创建布局对象，对UICollectionView进行控制
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 创建ViewController是设置flowLayout
        // 如果直接创建不提供布局将包异常 UICollectionView must be initialized with a non-nil layout parameter
        SwipCollectionViewController* viewController = [[SwipCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        vc = viewController;
    } else {
        //通用pushview
        vc = [[NSClassFromString([self titleForCellAtIndexPath:indexPath]) alloc] init];
    }
    
    vc.title = vcTitle;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - OtherMethods

- (void)testSelectorMethod
{
    //实例方法
    id webViewController;
    Class myInstanceClass = NSClassFromString(@"WebViewController");
    if (myInstanceClass) {
        webViewController = [myInstanceClass new];
    }
    SEL instanceSel = NSSelectorFromString(@"cleanWebViewCache:withText:");
    if (webViewController && [webViewController respondsToSelector:instanceSel]) {
        [webViewController performSelector:instanceSel withObject:@"aaaaa" withObject:@"bbbbb"];
    }
    
    //类方法
    Class myClass = NSClassFromString(@"WebViewController");
    SEL sel = NSSelectorFromString(@"testMethod:withText:");
    if (myClass && [myClass respondsToSelector:sel]) {
        [[myClass class] performSelector:sel withObject:@"aaa" withObject:@"bbb"];
    }
}

@end
