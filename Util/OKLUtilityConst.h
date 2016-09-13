//
//  OKLUtilityConst.h
//  KLDailyTest
//
//  Created by YanqingLee on 16/8/31.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 过期提醒
#define OKLUtilityDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// RGB颜色
#define MJRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 常量
UIKIT_EXTERN const CGFloat OKLUtilitySlowAnimationDuration;

UIKIT_EXTERN NSString *const OKLUtilityKeyPathContentOffset;


@interface OKLUtilityConst : NSObject

@end
