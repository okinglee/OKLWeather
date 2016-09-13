//
//  ExtendLog.m
//  KLLog
//
//  Created by YanqingLee on 15/11/16.
//  Copyright © 2015年 YanqingLee. All rights reserved.
//

#import "ExtendLog.h"

//@implementation ExtendLog
//
//@end

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...) {
    
    va_list ap;
    
    va_start(ap, format);
    
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end(ap);
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s",
            functionName,
            [fileName UTF8String],
            lineNumber,
            [body UTF8String]);
}