//
//  OKLServerInterface.h
//  OKLWeather
//
//  Created by YanqingLee on 16/9/9.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKLServerInterface : NSObject
+ (void)postRequest:(NSString *)urlString withParameters:(id)parameters success:(void (^)(id responseObject))sucess failure:(void (^)(NSError *error))failure;


+ (void)requestCityData:(NSString *)cityName success:(void (^)(id responseObjece))success failure:(void (^)(NSError *error))failure;
@end
