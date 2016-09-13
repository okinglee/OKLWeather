//
//  OKLLocationManager.h
//  KLDailyTest
//
//  Created by YanqingLee on 16/9/8.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OKLLocationManagerDelegate <NSObject>
- (void)okl_locationManagerDidUpdateLocation:(CLLocation *)location;
- (void)okl_locationManagerDidFailWithError:(NSError *)error;
@end

typedef void(^okl_placeMarkBlock) (CLPlacemark *placeMark);

@interface OKLLocationManager : NSObject
@property (nonatomic, weak) id<OKLLocationManagerDelegate> delegate;
@property (nonatomic, strong) okl_placeMarkBlock placeMarkBlock;
+ (OKLLocationManager *)getInstance;
- (BOOL)startLocate;
- (void)stopLocate;
- (void)locateGeographyAddress:(void (^)(CLPlacemark *placeMark))placeBlock;

@end

NS_ASSUME_NONNULL_END
