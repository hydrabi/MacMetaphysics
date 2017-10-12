//
//  NSNumber+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/12.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSNumber+Addition.h"

@implementation NSNumber (Addition)

+(NSInteger)getDayCountWithMonth:(NSInteger)month year:(NSInteger)year{
    NSInteger dayCount = 30;
    if(month == 2){
        if((year % 4 == 0 && year % 100 != 0)
           || year % 400 == 0){
            dayCount = 29;
        }
        else{
            dayCount = 28;
        }
    }
    else if (4 == month
             || 6 == month
             || 9 == month
             || 11 == month){
        dayCount = 30;
    }
    else{
        dayCount = 31;
    }
    return dayCount;
}

@end
