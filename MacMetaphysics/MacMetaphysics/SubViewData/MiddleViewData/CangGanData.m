//
//  CangGanData.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "CangGanData.h"
#import "NSString+Addition.h"
#import "NSArray+Addition.h"
#import "MainViewModel.h"
@implementation CangGanData

-(NSMutableDictionary *)cangGanDic{
    if(_cangGanDic == nil){
        NSString *branchesStr = [NSString branchesStr];
        NSArray *cangGanArr = [NSArray cangGanArray];
        _cangGanDic = @{}.mutableCopy;
        NSAssert(branchesStr.length == cangGanArr.count, @"地支藏干数目不相同");
        for(NSInteger i = 0;i<branchesStr.length;i++){
            [_cangGanDic setObject:cangGanArr[i]
                            forKey:[branchesStr substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return _cangGanDic;
}

-(NSString*)getCangGanWithGanZhi:(NSString*)ganZhi{
    NSAssert(ganZhi.length == 2, @"干支长度出现问题");
    
    //获取地支
    NSString *diZhi = [ganZhi substringWithRange:NSMakeRange(1, 1)];
    return self.cangGanDic[diZhi];
}

-(void)resetData{
    CurrentSelectDate *current = [MainViewModel sharedInstance].selectedDate;
    self.yearCangGan = [self getCangGanWithGanZhi:current.ganZhiYear];
    self.monthCangGan = [self getCangGanWithGanZhi:current.ganZhiMonth];
    self.dayCangGan = [self getCangGanWithGanZhi:current.ganZhiDay];
    self.hourCangGan = [self getCangGanWithGanZhi:current.ganZhiHour];
}

@end
