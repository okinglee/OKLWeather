//
//  OKLUtility.m
//  KLDailyTest
//
//  Created by YanqingLee on 16/8/28.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLUtility.h"

@implementation OKLUtility

static OKLUtility *instance = nil;
+ (OKLUtility *)getInstance {
    
    if (instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
    }
    return instance;
}


+ (void)showAlertView:(NSString *)title withMessage:(NSString *)message on:(UIViewController *)controller {
    [[self new] showAlertView:title withMessage:message on:controller];
}
- (void)showAlertView:(NSString *)title withMessage:(NSString *)message on:(UIViewController *)controller {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:actionCancel];
    [controller presentViewController:alertController animated:YES completion:nil];
}


+ (void)showAlertView:(NSString *)title withMessage:(NSString *)message delegate:(UIViewController *)controller {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:controller cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (BOOL)stringIsNullOrEmpty:(NSString *)string {
    
    if (!string) {
        return NO;
    }
    if (string.length == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    return [[self new] stringContainsEmoji:string];
}
- (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSString *)dataTOjsonString:(NSDictionary *)object {
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSString *)transformTimeFormatWithSecond:(NSInteger)second {
    return [[[self alloc] init] transformTimeFormatWithSecond:second];
}
- (NSString *)transformTimeFormatWithSecond:(NSInteger)second {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *baseTime   = [formatter dateFromString:@"1970-01-01 00:00:00"];
    NSDate *finalTime  = [baseTime dateByAddingTimeInterval:second];
    NSString *finalStr = [formatter stringFromDate:finalTime];
    NSString *time;
    if (second >= 3600) {
        time = [finalStr substringFromIndex:11];
    } else {
        time = [finalStr substringFromIndex:14];
    }
    return time;
}

+ (NSString *)deleteAddressSuffix:(NSString *)cityName {
    if (cityName.length <= 2) {
        return cityName;
    }
    NSString *conciseName = nil;
    if ([cityName hasSuffix:@"区"] || [cityName hasSuffix:@"市"]) {
        conciseName = [cityName substringToIndex:cityName.length-1];
        return conciseName;
    }
    return cityName;
}







@end
