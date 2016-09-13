//
//  ExtendLog.h
//  KLLog
//
//  Created by YanqingLee on 15/11/16.
//  Copyright © 2015年 YanqingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface ExtendLog : NSObject
//
//@end

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);