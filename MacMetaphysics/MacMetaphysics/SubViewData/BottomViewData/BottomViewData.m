//
//  BottomViewData.m
//  Metaphysics
//
//  Created by Hydra on 2017/4/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomViewData.h"
#import "MainViewModel.h"
#import "NSString+Addition.h"
@implementation BottomViewData

-(void)initialize{
    self.qiYunShu = -1;
    self.canStart = NO;
}

-(void)resetData{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    if(mainViewModel.useHourCountQiYun){
        [self countTimeOffset];
    }
    else{
        [self anotherCountTimeOffset];
    }
    
    [self countFirstIndexOfMonthInJiziArr];
}

-(void)clearData{
    self.qiYunShu = -1;
    self.canStart = NO;
}

#pragma mark - 起运数目
-(void)countTimeOffset{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    CurrentSelectDate *selectDate = mainViewModel.selectedDate;
    MiddleViewData *middleData = mainViewModel.middleData;
    RiZhuData *rizhu = mainViewModel.riZhuData;
    NSDate *leftTerm =  [self filterMinuteWithData:rizhu.leftTerm];
    NSDate *rightTerm = [self filterMinuteWithData:rizhu.rightTerm];
    NSDate *currentDate = selectDate.getGregorianDate;
    NSTimeInterval timeOffset = 0.0f;
    
    if(leftTerm && rightTerm){
        //男 阳顺阴逆
        if(middleData.universeType == UniverseTypeQian){
            
            if([[selectDate.ganZhiYear getBranches] isBranchesYang]){
                timeOffset = [rightTerm timeIntervalSinceDate:currentDate];
            }
            else{
                timeOffset = [currentDate timeIntervalSinceDate:leftTerm];
            }
        }
        //女 阳逆阴顺
        else{
            if([[selectDate.ganZhiYear getBranches] isBranchesYang]){
                timeOffset = [currentDate timeIntervalSinceDate:leftTerm];
            }
            else{
                timeOffset = [rightTerm timeIntervalSinceDate:currentDate];
            }
        }
        [self countAgeWithTiemOffset:timeOffset];
    }
}

//计算起运数
-(void)countAgeWithTiemOffset:(NSTimeInterval)timeOffset{
    NSInteger hour = 60 * 60;
    NSInteger day = 24 * hour;
    NSInteger oneAndHalfDay = 1.5 * day;
    NSInteger threeDay = day * 3;
    NSInteger age = (NSInteger)(timeOffset / threeDay);
    //余数
    NSInteger ageRemainder = (NSInteger)((NSInteger)timeOffset % threeDay);
    if(ageRemainder >= oneAndHalfDay){
        age += 1;
    }
    else{
        if(age == 0){
            age = 1;
        }
    }
    self.qiYunShu = age;
}

-(NSDate*)filterMinuteWithData:(NSDate*)currentDate{
    if(currentDate){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger year = [[dateFormatter stringFromDate:currentDate] integerValue];
        [dateFormatter setDateFormat:@"MM"];
        NSInteger month = [[dateFormatter stringFromDate:currentDate] integerValue];
        [dateFormatter setDateFormat:@"dd"];
        NSInteger day = [[dateFormatter stringFromDate:currentDate] integerValue];
        [dateFormatter setDateFormat:@"HH"];
        NSInteger hour = [[dateFormatter stringFromDate:currentDate] integerValue];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
        [components setYear:year];
        [components setMonth:month];
        [components setDay:day];
        [components setHour:hour];
        
        return [calendar dateFromComponents:components];
    }
    return nil;
}

#pragma mark - 另一种算起运数目的方法
-(void)anotherCountTimeOffset{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    CurrentSelectDate *selectDate = mainViewModel.selectedDate;
    MiddleViewData *middleData = mainViewModel.middleData;
    RiZhuData *rizhu = mainViewModel.riZhuData;
    NSDate *leftTerm =  [self filterHourWithData:rizhu.leftTerm];
    NSDate *rightTerm = [self filterHourWithData:rizhu.rightTerm];
    NSDate *currentDate = [self filterHourWithData:selectDate.getGregorianDate];
    NSTimeInterval timeOffset = 0.0f;
    
    if(leftTerm && rightTerm){
        //男 阳顺阴逆
        if(middleData.universeType == UniverseTypeQian){
            
            if([[selectDate.ganZhiYear getBranches] isBranchesYang]){
                rightTerm = [rightTerm dateByAddingTimeInterval:24 * 60 * 60];
                timeOffset = [rightTerm timeIntervalSinceDate:currentDate];
            }
            else{
                currentDate = [currentDate dateByAddingTimeInterval:24 * 60 * 60];
                timeOffset = [currentDate timeIntervalSinceDate:leftTerm];
            }
        }
        //女 阳逆阴顺
        else{
            if([[selectDate.ganZhiYear getBranches] isBranchesYang]){
                currentDate = [currentDate dateByAddingTimeInterval:24 * 60 * 60];
                timeOffset = [currentDate timeIntervalSinceDate:leftTerm];
            }
            else{
                rightTerm = [rightTerm dateByAddingTimeInterval:24 * 60 * 60];
                timeOffset = [rightTerm timeIntervalSinceDate:currentDate];
            }
        }
        [self anotherCountAgeWithTiemOffset:timeOffset];
    }
}

//计算起运数
-(void)anotherCountAgeWithTiemOffset:(NSTimeInterval)timeOffset{
    NSInteger hour = 60 * 60;
    NSInteger day = 24 * hour;
    NSInteger twoDay = 2 * day;
    NSInteger threeDay = day * 3;
    NSInteger age = (NSInteger)(timeOffset / threeDay);
    //余数
    NSInteger ageRemainder = (NSInteger)((NSInteger)timeOffset % threeDay);
    if(ageRemainder >= twoDay){
        age += 1;
    }
    else{
        if(age == 0){
            age = 1;
        }
    }
    self.qiYunShu = age;
}

-(NSDate*)filterHourWithData:(NSDate*)currentDate{
    if(currentDate){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger year = [[dateFormatter stringFromDate:currentDate] integerValue];
        [dateFormatter setDateFormat:@"MM"];
        NSInteger month = [[dateFormatter stringFromDate:currentDate] integerValue];
        [dateFormatter setDateFormat:@"dd"];
        NSInteger day = [[dateFormatter stringFromDate:currentDate] integerValue];
//        [dateFormatter setDateFormat:@"HH"];
//        NSInteger hour = [[dateFormatter stringFromDate:currentDate] integerValue];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
        [components setYear:year];
        [components setMonth:month];
        [components setDay:day];
        
        return [calendar dateFromComponents:components];
    }
    return nil;
}

#pragma mark - 大运排序
//计算月柱在甲子队列中的位置
-(void)countFirstIndexOfMonthInJiziArr{
    self.canStart = NO;
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    CurrentSelectDate *selectData = mainViewModel.selectedDate;
    NSArray *jiaZiArr = [MainViewModel sharedInstance].jiaZiArr;
    if(jiaZiArr.count>0){
        NSString *ganZhiMonth = selectData.ganZhiMonth;
        if(ganZhiMonth.length>0){
            //月柱在60甲子中的位置
            self.firstIndexOfYueZhu = [jiaZiArr indexOfObject:ganZhiMonth];
            if(self.qiYunShu>=0){
                self.canStart = YES;
            }
        }
    }

}

-(NSString*)getDaYunWithTableIndex:(NSInteger)tableIndex{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    MiddleViewData *middleData = mainViewModel.middleData;
    UniverseType type = middleData.universeType;
    CurrentSelectDate *selectData = mainViewModel.selectedDate;
    NSString *ganZhiYear = selectData.ganZhiYear;
    
    return [self getDaYunWithTableIndex:tableIndex
                    universeType:type
                                 ganZhi:ganZhiYear
                            yueZhuIndex:self.firstIndexOfYueZhu];
}

-(NSString*)getDaYunWithTableIndex:(NSInteger)tableIndex
                      universeType:(UniverseType)type
                            ganZhi:(NSString*)ganZhiYear
                       yueZhuIndex:(NSInteger)yueZhuIndex
{
    if(type == UniverseTypeQian){
        //男 阳顺阴逆
        if([[ganZhiYear getBranches] isBranchesYang]){
            return [self positiveOrderWithTableIndex:tableIndex
                                         yueZhuIndex:yueZhuIndex];
        }
        else{
            return [self reversedOrderWithTableIndex:tableIndex
                    yueZhuIndex:yueZhuIndex];
        }
    }
    else{
        //女 阳逆阴顺
        if([[ganZhiYear getBranches] isBranchesYang]){
            return [self reversedOrderWithTableIndex:tableIndex
                                         yueZhuIndex:yueZhuIndex];
        }
        else{
            return [self positiveOrderWithTableIndex:tableIndex
                                         yueZhuIndex:yueZhuIndex];
        }
    }
}

//逆序
-(NSString*)reversedOrderWithTableIndex:(NSInteger)tableIndex
                            yueZhuIndex:(NSInteger)yueZhuIndex{
    NSInteger realIndex = yueZhuIndex - tableIndex;
    NSArray *jiaZiArr = [MainViewModel sharedInstance].jiaZiArr;
    if(realIndex < 0){
        realIndex = jiaZiArr.count + realIndex;
    }
    return [jiaZiArr objectAtIndex:realIndex];
}

//顺序
-(NSString*)positiveOrderWithTableIndex:(NSInteger)tableIndex
                            yueZhuIndex:(NSInteger)yueZhuIndex{
    NSInteger realIndex = tableIndex + yueZhuIndex;
    NSArray *jiaZiArr = [MainViewModel sharedInstance].jiaZiArr;
    if(realIndex >= jiaZiArr.count){
        realIndex = realIndex - jiaZiArr.count;
    }
    return [jiaZiArr objectAtIndex:realIndex];
}

#pragma mark - 流年排序
-(void)fillContentWithTableIndex:(NSInteger)tableIndex
                          tableSection:(NSInteger)tableSection
                              tableRow:(NSInteger)tableRow
                                 block:(void(^)(NSString *liuNian,NSString *xiaoYun,NSString *year))block{
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    BottomViewData *bottomData = mainViewModle.bottomData;
    CurrentSelectDate *selectData = mainViewModle.selectedDate;
    MiddleViewData *middleData = mainViewModle.middleData;
    
    NSString *ganZhiYear = selectData.ganZhiYear;
    NSArray *jiaZiArr = mainViewModle.jiaZiArr;
    
    NSString *liuNian = @"";
    NSString *xiaoYun = @"";
    NSString *year = @"";
    if(jiaZiArr.count>0 && bottomData.qiYunShu>=0){
        NSInteger firstLineTableViewShow = rowPerVerticalLine - (bottomData.qiYunShu - 1);
        NSInteger realIndex = rowPerVerticalLine * tableIndex + tableSection * rowPerSection + tableRow;
        NSInteger indexOffset = realIndex - firstLineTableViewShow;

        if(realIndex >= firstLineTableViewShow){
            if(middleData.universeType == UniverseTypeQian){
                //男 阳顺阴逆
                if([[ganZhiYear getBranches] isBranchesYang]){
                    liuNian = [self getLiuNianPositiveOrderWithIndexOffset:indexOffset];
                    xiaoYun = [self getXiaoYunPositiveOrderWithIndexOffset:indexOffset];
                }
                else{
                    liuNian = [self getLiuNianPositiveOrderWithIndexOffset:indexOffset];
                    xiaoYun = [self getXiaoYunReversedOrderWithIndexOffset:indexOffset];
                }
            }
            else{
                //女 阳逆阴顺
                if([[ganZhiYear getBranches] isBranchesYang]){
                    liuNian = [self getLiuNianPositiveOrderWithIndexOffset:indexOffset];
                    xiaoYun = [self getXiaoYunReversedOrderWithIndexOffset:indexOffset];
                }
                else{
                    liuNian = [self getLiuNianPositiveOrderWithIndexOffset:indexOffset];
                    xiaoYun = [self getXiaoYunPositiveOrderWithIndexOffset:indexOffset];
                }
            }
            
            if(selectData.gregorianYear.integerValue >0){
                year = [NSString stringWithFormat:@"%ld",selectData.gregorianYear.integerValue + indexOffset] ;
            }
        }
    }
    
    if(block){
        block(liuNian,xiaoYun,year);
    }
}


//逆序
-(NSString*)getLiuNianReversedOrderWithIndexOffset:(NSInteger)indexOffset{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    CurrentSelectDate *selectData = mainViewModle.selectedDate;
    NSArray *jiaZiArr = mainViewModle.jiaZiArr;
    NSInteger ganZhiYearIndex = [jiaZiArr indexOfObject:selectData.ganZhiYear];
    
    //减去偏移量获得实际位置
    NSInteger locationIndex = ganZhiYearIndex - indexOffset ;
    //少于0，补正locationIndex
    if(locationIndex<0){
        NSInteger divisor = (NSInteger)((-locationIndex) / jiaZiArr.count) + 1;
        locationIndex = jiaZiArr.count * divisor + locationIndex;
        //等于60的情况
        if(locationIndex == jiaZiArr.count){
            locationIndex = 0;
        }
    }
    
    if(jiaZiArr.count>locationIndex){
       return jiaZiArr[locationIndex];
    }
    return @"";
}

//顺序
-(NSString*)getLiuNianPositiveOrderWithIndexOffset:(NSInteger)indexOffset{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    CurrentSelectDate *selectData = mainViewModle.selectedDate;
    NSArray *jiaZiArr = mainViewModle.jiaZiArr;
    NSInteger ganZhiYearIndex = [jiaZiArr indexOfObject:selectData.ganZhiYear];
    
    NSInteger locationIndex = indexOffset + ganZhiYearIndex;
    //超出60，引用余数
    if(locationIndex >= jiaZiArr.count){
        NSInteger yushu = locationIndex / jiaZiArr.count;
        locationIndex = locationIndex - jiaZiArr.count * yushu;
    }

    if(jiaZiArr.count>locationIndex){
        return jiaZiArr[locationIndex];
    }
    return @"";
}

//小运逆序
-(NSString*)getXiaoYunReversedOrderWithIndexOffset:(NSInteger)indexOffset{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    CurrentSelectDate *selectData = mainViewModle.selectedDate;
    NSArray *jiaZiArr = mainViewModle.jiaZiArr;
    NSInteger ganZhiHourIndex = [jiaZiArr indexOfObject:selectData.ganZhiHour];
    
    //减去偏移量获得实际位置
    NSInteger locationIndex = ganZhiHourIndex - indexOffset ;
    //少于0，补正locationIndex
    if(locationIndex<0){
        NSInteger divisor = (NSInteger)((-locationIndex) / jiaZiArr.count) + 1;
        locationIndex = jiaZiArr.count * divisor + locationIndex;
        //等于60的情况
        if(locationIndex == jiaZiArr.count){
            locationIndex = 0;
        }
    }
    
    if(jiaZiArr.count>locationIndex){
        return jiaZiArr[locationIndex];
    }
    return @"";
}

//小运顺序
-(NSString*)getXiaoYunPositiveOrderWithIndexOffset:(NSInteger)indexOffset{
    
    MainViewModel *mainViewModle = [MainViewModel sharedInstance];
    CurrentSelectDate *selectData = mainViewModle.selectedDate;
    NSArray *jiaZiArr = mainViewModle.jiaZiArr;
    NSInteger ganZhiHourIndex = [jiaZiArr indexOfObject:selectData.ganZhiHour];
    
    NSInteger locationIndex = indexOffset + ganZhiHourIndex;
    //超出60，引用余数
    if(locationIndex >= jiaZiArr.count){
        NSInteger yushu = locationIndex / jiaZiArr.count;
        locationIndex = locationIndex - jiaZiArr.count * yushu;
    }
    
    if(jiaZiArr.count>locationIndex){
        return jiaZiArr[locationIndex];
    }
    return @"";
}

@end
