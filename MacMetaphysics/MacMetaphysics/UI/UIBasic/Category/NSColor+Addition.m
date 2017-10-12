//
//  UIColor+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/4/22.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSColor+Addition.h"

@implementation NSColor (Addition)

+(NSColor*)getColorWithString:(NSString*)targetStr{
    NSString *greenStr = @"甲乙寅卯木";
    
    NSString *redStr      = @"丙丁巳午火";
    
    NSString *brownStr = @"戊己辰戌丑未土";
    
    NSString *goldenStr = @"庚辛申酉金";
    
    NSString *blueStr = @"壬癸亥子水";
    
    NSArray *strArr = @[greenStr,
                        redStr,
                        brownStr,
                        goldenStr,
                        blueStr];
    
    for(NSInteger i = 0;i<strArr.count;i++){
        NSString *str = strArr[i];
        for(NSInteger j = 0;j<str.length;j++){
            NSString *charater = [str substringWithRange:NSMakeRange(j, 1)];
            if([targetStr containsString:charater]){
                return [self getColorWithIndex:i];
            }
        }
    }
    
    return [NSColor blackColor];
}

+(NSColor*)getColorWithIndex:(NSInteger)index{
    NSColor *color = [NSColor blackColor];
    switch (index) {
        case 0:
        {
            color = [NSColor greenColor];
        }
            break;
        case 1:
        {
            color = [NSColor redColor];
        }
            break;
        case 2:
        {
            color = [NSColor brownColor];
        }
            break;
        case 3:
        {
            color = [NSColor colorWithRed:252/255.0
                                    green:202/255.0
                                     blue:0/255.0
                                    alpha:1];
        }
            break;
        case 4:
        {
            color = [NSColor blueColor];
        }
            break;
            
        default:
            break;
    }
    return color;
}

@end
