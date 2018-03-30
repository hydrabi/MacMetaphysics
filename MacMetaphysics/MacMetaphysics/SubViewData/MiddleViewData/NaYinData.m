//
//  NaYinData.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NaYinData.h"
#import "NSArray+Addition.h"
#import "NSString+Addition.h"
#import "MainViewModel.h"
@implementation NaYinData
-(NSMutableDictionary*)naYinDic{
    if(_naYinDic == nil){
        _naYinDic = @{}.mutableCopy;
        NSArray *jiaZiArr = [NSArray jiaZiArr];
        NSArray *naYinArr = [NSArray naYinArray];
        NSAssert(naYinArr.count == jiaZiArr.count/2, @"甲子数目不为纳音数目的两倍");
        
        for(NSInteger i = 0 ; i < jiaZiArr.count;i++){
            NSString *jiaZi = jiaZiArr[i];
            NSInteger naYinIndex = (NSInteger)floor(i/2);
            NSString *naYin = naYinArr[naYinIndex];
            [_naYinDic setObject:naYin
                          forKey:jiaZi];
        }
    }
    return _naYinDic;
}

-(void)resetData{
    CurrentSelectDate *current = [MainViewModel sharedInstance].selectedDate;
    self.yearNaYin = self.naYinDic[current.ganZhiYear];
    self.monthNaYin = self.naYinDic[current.ganZhiMonth];
    self.dayNaYin = self.naYinDic[current.ganZhiDay];
    self.hourNaYin = self.naYinDic[current.ganZhiHour];
}

-(void)clearData{
    _yearNaYin  = @"";
    _monthNaYin = @"";
    _dayNaYin   = @"";
    _hourNaYin  = @"";
}
@end
