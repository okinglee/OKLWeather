//
//  OKLMainVC.m
//  OKLWeather
//
//  Created by YanqingLee on 16/9/7.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLMainVC.h"
#import "OKLContentPVC.h"
#import "OKLLocationManager.h"
#import "OKLServerInterface.h"
#import "OKLUtility.h"
#import "OKLMeshParticleEmitter.h"

@interface OKLMainVC ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageContentArray;

@end

//NSString *const kLocateAddressSuccessNotification = @"okl_locateAddressSuccessNotification";

@implementation OKLMainVC

#pragma mark - lazy loading
- (NSArray *)pageContentArray {
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 1; i < 2; i++) {
//            NSString *contentString = [[NSString alloc] initWithFormat:@"This is the page %d of content displayed using UIPageViewController", i];
            NSString *contentString = @"城市名";
            [arrayM addObject:contentString];
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
        
    }
    return _pageContentArray;
}

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequestData:) name:kLocateAddressSuccessNotification object:nil];
    [self pageViewControllerSetting];
    [self locateGeographyAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - <UIPageViewControllerDataSource>
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(OKLContentPVC *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(OKLContentPVC *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Functions By Okl
// Page Setting
- (void)pageViewControllerSetting {
    
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    OKLContentPVC *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];

    _pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}

- (OKLContentPVC *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    OKLContentPVC *contentVC = [[OKLContentPVC alloc] init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    return contentVC;
}

- (NSUInteger)indexOfViewController:(OKLContentPVC *)viewController {
    return [self.pageContentArray indexOfObject:viewController.content];
}

// Locate Setting
- (void)locateGeographyAddress {
    [[OKLLocationManager getInstance] locateGeographyAddress:^(CLPlacemark * _Nonnull placeMark) {
        NSDictionary *addressDic = placeMark.addressDictionary;
//        OKLLog(@"city: %@",addressDic[@"City"]);
        NSNotification *notification = [[NSNotification alloc] initWithName:kLocateAddressSuccessNotification object:nil userInfo:addressDic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}

/*!
 *  请求城市天气数据
 */
- (void)startRequestWeatherData:(NSString *)cityName {
    [OKLServerInterface requestCityData:cityName success:^(id responseObjece) {
//        OKLLog(@"startRequestWeatherData: %@",responseObjece);
        [OKLMeshParticleEmitter snowOn:self];
    } failure:^(NSError *error) {
//        OKLLog(@"startRequestWeatherData: %@",error);
    }];
}

#pragma mark - Custom Notification Method

- (void)startRequestData:(NSNotification *)notification {
    NSString *cityName = [OKLUtility deleteAddressSuffix:notification.userInfo[@"City"]];
    
    [self startRequestWeatherData:cityName];
}





















@end
