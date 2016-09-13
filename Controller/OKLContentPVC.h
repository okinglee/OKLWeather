//
//  OKLContentPVC.h
//  OKLWeather
//
//  Created by YanqingLee on 16/9/7.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKLContentPVC : UIPageViewController
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@end
