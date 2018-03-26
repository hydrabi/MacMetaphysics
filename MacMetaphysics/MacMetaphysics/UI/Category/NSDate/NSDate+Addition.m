//
//  NSDate+Addition.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/26.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "NSDate+Addition.h"
#import <Foundation/Foundation.h>

@implementation NSDate (Addition)

- (NSString *)toStringWithFormat:(NSString*)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
    
}

@end
