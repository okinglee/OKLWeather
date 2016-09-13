//
//  OKLLocationManager.m
//  KLDailyTest
//
//  Created by YanqingLee on 16/9/8.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLLocationManager.h"
#import <UIKit/UIKit.h>

@interface OKLLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *kLocationManager;
@property (nonatomic, strong) CLGeocoder        *geocoder;
@property (nonatomic, strong) CLLocation        *location;
@end

@implementation OKLLocationManager

#pragma mark - lazy loading 
- (CLLocationManager *)kLocationManager {
    
    if (_kLocationManager == nil) {
        _kLocationManager = [[CLLocationManager alloc] init];
    }
    return _kLocationManager;
}

- (CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

#pragma mark - init method
static OKLLocationManager *gInstance;
+ (OKLLocationManager *)getInstance {
    
    if (gInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gInstance = [[self alloc] init];
        });
    }
    return gInstance;
}
- (instancetype)init {
    self.kLocationManager.delegate = self;
    return [super init];
}

#pragma mark - Functions By Okl
- (BOOL)startLocate {
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    BOOL isAuthorized = (status == kCLAuthorizationStatusAuthorized) || (status == kCLAuthorizationStatusAuthorizedAlways) || (status == kCLAuthorizationStatusAuthorizedWhenInUse);
    if (isAuthorized) {
        [self.kLocationManager startUpdatingLocation];
        return YES;
    }
    self.kLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.kLocationManager.distanceFilter = 500;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8) {
        [self.kLocationManager requestWhenInUseAuthorization];
    } else {
        [self.kLocationManager startUpdatingLocation];
    }
    
    return YES;
}

- (void)stopLocate {
    [self.kLocationManager stopUpdatingLocation];
}


#pragma mark - < CLLocationManagerDelegate >
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    BOOL allowLocate = (status == kCLAuthorizationStatusAuthorizedWhenInUse) || (status == kCLAuthorizationStatusAuthorized) || (status == kCLAuthorizationStatusAuthorizedAlways);
    if (allowLocate) {
        [self.kLocationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.kLocationManager stopUpdatingLocation];
    self.location = locations.lastObject;
    [self.delegate okl_locationManagerDidUpdateLocation:locations.lastObject];
    [self reverseGeocoderWithLocation:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.delegate okl_locationManagerDidFailWithError:error];
}


#pragma mark - CLGeocoder 
- (void)reverseGeocoderWithLocation:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (self.placeMarkBlock) {
                self.placeMarkBlock(placemarks.lastObject);
            }
        }
    }];
}

- (void)locateGeographyAddress:(void (^)(CLPlacemark *placeMark))placeBlock {
    BOOL startedLocate = [self startLocate];
    if (!startedLocate) {
        return;
    }
    self.placeMarkBlock = placeBlock;
}

@end
