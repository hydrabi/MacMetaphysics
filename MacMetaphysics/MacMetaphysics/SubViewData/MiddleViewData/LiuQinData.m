//
//  LiuQinData.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "LiuQinData.h"
#import "NSString+Addition.h"
#import "MainViewModel.h"
#import "NSDictionary+Addition.h"
@implementation LiuQinData

-(NSMutableDictionary*)liuQinDic{
    if(_liuQinDic == nil){
        _liuQinDic = [NSDictionary liuQinDic].mutableCopy;
    }
    return _liuQinDic;
    
}

-(NSString*)getLiuQinValueWithRiGanZhi:(NSString*)riGanZhi otherGanZhi:(NSString*)otherGanZhi{
    NSString* result = @"";
    NSAssert(riGanZhi != nil, @"日干支为空");
    NSAssert(otherGanZhi != nil, @"其它干支为空");
    NSString *riGan = [riGanZhi getStems];
    NSString *otherGan = [otherGanZhi getStems];
    NSNumber *typeNumber  = self.liuQinDic[riGan][otherGan];
    result = [NSString getValueWithType:(liuQinType)typeNumber.integerValue];
    return result;
}

-(NSString*)getLiuQinValueWithRiGanZhi:(NSString*)riGanZhi cangGan:(NSString*)cangGan{
    NSString* result = @"";
    NSAssert(riGanZhi != nil, @"日干支为空");
    NSAssert(cangGan != nil, @"藏干为空");
    NSString *riGan = [riGanZhi substringWithRange:NSMakeRange(0, 1)];
    for(NSInteger i = 0 ;i<cangGan.length;i++){
        NSString *otherGan = [cangGan substringWithRange:NSMakeRange(i, 1)];
        NSNumber *typeNumber  = self.liuQinDic[riGan][otherGan];
        result = [result stringByAppendingString:[NSString getValueWithType:(liuQinType)typeNumber.integerValue]];
    }
    
    return result;
}

-(void)resetData{
    CurrentSelectDate *current = [MainViewModel sharedInstance].selectedDate;
    CangGanData *cangGanData = [MainViewModel sharedInstance].middleData.cangGanData;
    self.yearTopLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                              otherGanZhi:current.ganZhiYear];
    self.monthTopLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                              otherGanZhi:current.ganZhiMonth];
    self.dayTopLiuQin = @"日干";
    self.hourTopLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                              otherGanZhi:current.ganZhiHour];
    
    self.yearBottomLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                                     cangGan:cangGanData.yearCangGan];
    self.monthBottomLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                                     cangGan:cangGanData.monthCangGan];
    self.dayBottomLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                                     cangGan:cangGanData.dayCangGan];
    self.hourBottomLiuQin = [self getLiuQinValueWithRiGanZhi:current.ganZhiDay
                                                     cangGan:cangGanData.hourCangGan];
}

@end
