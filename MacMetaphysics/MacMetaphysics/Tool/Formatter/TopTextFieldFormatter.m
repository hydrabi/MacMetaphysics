//
//  TopTextFieldFormatter.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/1.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "TopTextFieldFormatter.h"

@implementation TopTextFieldFormatter

-(instancetype)initWithType:(TopViewFormatterType)type{
    self = [super init];
    if(self){
        _formatterType = type;
    }
    return self;
}

-(BOOL)isPartialStringValid:(NSString *__autoreleasing  _Nonnull *)partialStringPtr
      proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
             originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange
           errorDescription:(NSString *__autoreleasing  _Nullable *)error{
    
    if(self.formatterType == TopViewFormatterTypeYear){
        //年份长度不能超过4位
        if([*partialStringPtr length] > 4){
            return NO;
        }
    }
    else if(self.formatterType == TopViewFormatterTypeMonth){
        //月份长度限制
        if([*partialStringPtr length]>2){
            return NO;
        }
        //月份大小限制
        if([*partialStringPtr integerValue]>12){
            return NO;
        }
    }
    else if(self.formatterType == TopViewFormatterTypeDay){
        //月份天数长度限制
        if([*partialStringPtr length]>2){
            return NO;
        }
        //月份天数大小限制
        if([*partialStringPtr integerValue]>31){
            return NO;
        }
    }
    else if(self.formatterType == TopViewFormatterTypeHour){
        //小时长度限制
        if([*partialStringPtr length]>2){
            return NO;
        }
        //月份天数大小限制
        if([*partialStringPtr integerValue]>=24){
            return NO;
        }
    }
    static NSCharacterSet *nonDecimalCharacters = nil;
    if (nonDecimalCharacters == nil) {
        nonDecimalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet] ;
    }
    
    if([*partialStringPtr length] == 0){
        return YES;
    }
    else if([*partialStringPtr rangeOfCharacterFromSet:nonDecimalCharacters].location != NSNotFound){
        return NO;
    }
    
    return YES;
}

@end
