//
//  OKLServerInterface.m
//  OKLWeather
//
//  Created by YanqingLee on 16/9/9.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLServerInterface.h"
#import "AFNetworking.h"

#define HE_WEATHER_URL @"https://api.heweather.com/x3/weather?cityid=城市ID&key=你的认证key"
#define HE_WEATHER_API_KEY @"53b0509092304b4b9296a34b351f0d0c"

@implementation OKLServerInterface

+ (void)postRequest:(NSString *)urlString
     withParameters:(id)parameters
            success:(void (^)(id responseObject))sucess
            failure:(void (^)(NSError *error))failure {
    
    
}



+ (void)requestCityData:(NSString *)cityName success:(void (^)(id responseObjece))success failure:(void (^)(NSError *error))failure {
    NSString *urlString = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=CN101020100&key=53b0509092304b4b9296a34b351f0d0c"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        } else {
            if (success) {
                NSError *jsonError;
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                if (jsonError) {
                    success(nil);
                }
                success(dataDic);
            }
        }
    }];
    [task resume];
}

/*
 + (void)requestCityData:(NSString *)cityName success:(void (^)(id responseObjece))success failure:(void (^)(NSError *error))failure {
 
 }
 */


@end
