//
//  OKLUtility.h
//  KLDailyTest
//
//  Created by YanqingLee on 16/8/28.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OKLUtilityConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKLUtility : NSObject

//> init method

/*!
 *  Creates and returns an `OKLUtility` object.
 *
 *  @return OKLUtility object
 */
+ (OKLUtility *)getInstance;


//> Alert

/*!
 *  UIAlertController类 警示框
 *
 *  @param title      title
 *  @param message    message
 *  @param controller controller
 */
+ (void)showAlertView:(NSString *)title withMessage:(NSString *)message on:(UIViewController *)controller NS_AVAILABLE_IOS(8_0);

/*!
 *  UIAlertView类 警示框
 *
 *  @param title      title
 *  @param message    message
 *  @param controller controller
 */
+ (void)showAlertView:(NSString *)title withMessage:(NSString *)message delegate:(UIViewController *)controller OKLUtilityDeprecated("Use UIAlertController instead.");


//> Judge

/*!
 *  判断字符串是否为空
 *
 *  @param string string
 *
 *  @return bool
 */
+ (BOOL)stringIsNullOrEmpty:(NSString *)string;

/*!
 *  判断字符串是否含有emoji表情
 *
 *  @param string string
 *
 *  @return bool
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

//>> Regular



//> Transform

/*!
 *  字典转JSON
 *
 *  @param object dic
 *
 *  @return json string
 */
+ (NSString *)dataTOjsonString:(NSDictionary *)object;

/*!
 *  秒数转时间，限24小时内
 *
 *  @param second second
 *
 *  @return 1小时内，mm:ss;大于1小时,HH:mm:ss
 */
+ (NSString *)transformTimeFormatWithSecond:(NSInteger)second;

//> String Process

/*!
 *  (中文字符)删除地名后缀，如：上海市-上海，普陀区-普陀；特例，沙市。
 *
 *  @param cityName 原地名
 *
 *  @return 去掉市、区后的地名
 */
+ (NSString *)deleteAddressSuffix:(NSString *)cityName;














@end

NS_ASSUME_NONNULL_END
