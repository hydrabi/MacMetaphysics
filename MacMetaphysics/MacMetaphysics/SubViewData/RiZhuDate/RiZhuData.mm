//
//  RiZhuDate.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "RiZhuData.h"
#import "MainViewModel.h"
#import "NSArray+Addition.h"
#import "TTLunarCalendar.h"
#import "NSNumber+Addition.h"
@implementation RiZhuData

-(void)initialize{
    [super initialize];
    self.allTermsDateArr = @[].mutableCopy;
    self.lastYearAllTermsDateArr = @[].mutableCopy;
    self.nextYearAllTermsDateArr = @[].mutableCopy;
    self.solarDate = @[].mutableCopy;
    self.lunarDate = @[].mutableCopy;
}

-(void)resetTermWithYear:(NSInteger)year{
    self.currentSolarYear = year;
    [self.allTermsDateArr removeAllObjects];
    //取该年节气的日期集合
    NSMutableArray *termsDate = [[MainViewModel sharedInstance] getTremWithYear:(int32_t)year];
    //取该年节气的时间集合
    NSArray *solarTermTimeArr = [[MainViewModel sharedInstance].solarTermsTimeDic objectForKey:[NSString stringWithFormat:@"%ld",(long)year]];
    
    self.allTermsDateArr = [NSArray allTermsDateArrWithYear:year
                                           solarTermTimeArr:solarTermTimeArr
                                                  termsDate:termsDate];
    [self dealWithRiZhuData];
}

-(void)getTermWithLastYear:(NSInteger)lastYear{
    if(lastYear<1900){
        [self.lastYearAllTermsDateArr removeAllObjects];
        NSLog(@"超过1900上限，没有上一年");
        return;
    }
    
    NSMutableArray *termsDate = [[MainViewModel sharedInstance] getTremWithYear:(int32_t)lastYear];
    
    //取该年节气的时间集合
    NSArray *solarTermTimeArr = [[MainViewModel sharedInstance].solarTermsTimeDic objectForKey:[NSString stringWithFormat:@"%ld",(long)lastYear]];
    
    self.lastYearAllTermsDateArr = [NSArray allTermsDateArrWithYear:lastYear
                                                   solarTermTimeArr:solarTermTimeArr
                                                          termsDate:termsDate];
}

-(void)getTermWithNextYear:(NSInteger)nextYear{
    if(nextYear>2100){
        [self.nextYearAllTermsDateArr removeAllObjects];
        NSLog(@"超过2100上限，没有下一年");
        return;
    }
    
    NSMutableArray *termsDate = [[MainViewModel sharedInstance] getTremWithYear:(int32_t)nextYear];
    
    //取该年节气的时间集合
    NSArray *solarTermTimeArr = [[MainViewModel sharedInstance].solarTermsTimeDic objectForKey:[NSString stringWithFormat:@"%ld",(long)nextYear]];
    
    self.nextYearAllTermsDateArr = [NSArray allTermsDateArrWithYear:nextYear
                                                   solarTermTimeArr:solarTermTimeArr
                                                          termsDate:termsDate];
}

//早于小寒取上年的大雪作为前边的节气，为子月，大雪-小寒
//早于立春为丑月，小寒-立春
//早于惊蛰为寅月，立春-惊蛰
//早于清明为卯月，惊蛰-清明
//早于立夏为辰月，清明-立夏
//早于芒种为巳月，立夏-芒种
//早于小暑为午月，芒种-小暑
//早于立秋为未月，小暑-立秋
//早于白露为申月，立秋-白露
//早于寒露为酉月，白露-寒露
//早于立冬为戌月，寒露-立冬
//早于大雪为亥月，立冬-大雪
//超过大雪，取下一年的小寒作为右边的节气，为子月，大雪-小寒
-(void)dealWithRiZhuData{
    NSDate *selectedDate = [[MainViewModel sharedInstance].selectedDate getGregorianDate];
    NSArray *monthNames = [NSArray monthNameArr];
    for(NSInteger i = 0;i<self.allTermsDateArr.count;i+=2){
        NSDate *term = self.allTermsDateArr[i];
        if([selectedDate compare:term] == NSOrderedAscending){
            //早于小寒取上年的大雪作为前边的节气，为子月，大雪-小寒
            if(0 == i){
                [self getTermWithLastYear:([MainViewModel sharedInstance].selectedDate.gregorianYear.integerValue-1)];
                NSInteger daXueIndex = [[NSArray termsNameArr] indexOfObject:@"大雪"];
                if(self.lastYearAllTermsDateArr.count>(daXueIndex+1)){
                    self.leftTerm = self.lastYearAllTermsDateArr[daXueIndex];
                    self.rightTerm = self.allTermsDateArr[i];
                    self.leftTermName = [[NSArray termsNameArr] objectAtIndex:daXueIndex];
                    self.rightTermName = [[NSArray termsNameArr] objectAtIndex:i];
                    self.separatorDayArr = [NSArray separatorDayWithMonth:monthNames.count-1];
                    self.separatorDayNameArr = [NSArray separatorDayNameWithMonth:monthNames.count-1];
                    NSString *ganZhiDay = [MainViewModel sharedInstance].selectedDate.ganZhiDay;
                    self.indexOfTermsBranchName = [[MainViewModel sharedInstance].jiaZiArr indexOfObject:ganZhiDay];
                    //子月
                    self.monthName = [monthNames objectAtIndex:monthNames.count-1];
                }
            }
            else{
                self.leftTerm = self.allTermsDateArr[i-2];
                self.rightTerm = self.allTermsDateArr[i];
                self.leftTermName = [[NSArray termsNameArr] objectAtIndex:i-2];
                self.rightTermName = [[NSArray termsNameArr] objectAtIndex:i];
                self.monthName = [monthNames objectAtIndex:(NSInteger)((i-2)/2)];
                self.separatorDayArr = [NSArray separatorDayWithMonth:(NSInteger)((i-2)/2)];
                self.separatorDayNameArr = [NSArray separatorDayNameWithMonth:(NSInteger)((i-2)/2)];
            }
            [self getFirstDay];
            [self createDate];
            [self getCurrentSolarTerms];
            break;
        }
        else{
            //最后判断超过大雪，取下一年的小寒作为右边的节气，为子月，大雪-小寒
            if(i == 22){
                
                [self getTermWithNextYear:([MainViewModel sharedInstance].selectedDate.gregorianYear.integerValue+1)];
                NSInteger xiaoHanIndex = [[NSArray termsNameArr] indexOfObject:@"小寒"];
                if(self.nextYearAllTermsDateArr.count>(xiaoHanIndex+1)){
                    
                    self.leftTerm = self.allTermsDateArr[i];
                    self.rightTerm = self.nextYearAllTermsDateArr[xiaoHanIndex];
                    self.leftTermName = [[NSArray termsNameArr] objectAtIndex:i];
                    self.rightTermName = [[NSArray termsNameArr] objectAtIndex:xiaoHanIndex];
                    self.separatorDayArr = [NSArray separatorDayWithMonth:monthNames.count-1];
                    self.separatorDayNameArr = [NSArray separatorDayNameWithMonth:monthNames.count-1];
                    NSString *ganZhiDay = [MainViewModel sharedInstance].selectedDate.ganZhiDay;
                    self.indexOfTermsBranchName = [[MainViewModel sharedInstance].jiaZiArr indexOfObject:ganZhiDay];
                    //子月
                    self.monthName = [monthNames objectAtIndex:monthNames.count-1];
                    [self getFirstDay];
                    [self createDate];
                    [self getCurrentSolarTerms];
                }
            }
        }
    }
    
}

//获取当前的节气
-(void)getCurrentSolarTerms{
    self.currentTermName = @"";
    NSDate *selectedDate = [[MainViewModel sharedInstance].selectedDate getGregorianDate];
    NSArray *termsNameArr = [NSArray termsNameArr];
    for(NSInteger i = 0;i<self.allTermsDateArr.count;i++){
        NSDate *term = self.allTermsDateArr[i];
        if([selectedDate compare:term] == NSOrderedAscending){
            //早于小寒为冬至，否则为上一个节气
            if(0 == i){
                self.currentTermName = [termsNameArr objectAtIndex:termsNameArr.count-1];
            }
            else{
                self.currentTermName = [termsNameArr objectAtIndex:i-1];
            }
            break;
        }
    }
}

//取节气得第一天
-(void)getFirstDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hour = [dateFormatter stringFromDate:self.leftTerm];
    //（有时节气时间会超过晚上11点，延顺到下一天）
    if([hour isEqualToString:@"23"]){
        //实际时间无关紧要，只要是下一天就可以，所以添加一小时后变成下一天
        self.firstDayOfTheMonth = [self.leftTerm dateByAddingTimeInterval:60*60];
    }
    else{
        self.firstDayOfTheMonth = self.leftTerm;
    }
    TTLunarDate *lunarDate = [TTLunarCalendar convertFromGeneralDate:self.firstDayOfTheMonth];
    self.indexOfTermsBranchName = [[MainViewModel sharedInstance].jiaZiArr indexOfObject:lunarDate.ganzhiDay];
}
//又第一天获取之后的日期
-(void)createDate{
    [self.solarDate removeAllObjects];
    [self.lunarDate removeAllObjects];
    CurrentSelectDate *selectDate = [MainViewModel sharedInstance].selectedDate;
    
    //左边节气的月
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSInteger year = [[dateFormatter stringFromDate:self.firstDayOfTheMonth] integerValue];
    [dateFormatter setDateFormat:@"MM"];
    NSInteger month = [[dateFormatter stringFromDate:self.firstDayOfTheMonth] integerValue];
    [dateFormatter setDateFormat:@"dd"];
    NSInteger day = [[dateFormatter stringFromDate:self.firstDayOfTheMonth] integerValue];
    NSInteger dayCount = [NSNumber getDayCountWithMonth:month
                                                   year:year];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    [components setYear:year];
    [components setMonth:month];
    
    
    for(NSInteger i = day;i<=dayCount;i++){
        [components setDay:i];
        NSDate *date = [calendar dateFromComponents:components];
        [self.solarDate addObject:@(i)];
        TTLunarDate *lunarDate = [TTLunarCalendar convertFromGeneralDate:date];
        [self.lunarDate addObject:lunarDate.lunarDayInChinese];
        
        if(lunarDate.lunarMonth == selectDate.lunarMonth.integerValue &&
           lunarDate.lunarDay == selectDate.lunarDay.integerValue){
            self.indexOfCurrentDay = self.lunarDate.count-1;
        }
    }
    
    
    
    //右边节气的月
    //左边已经算好的日数的天数，防止超过31天
    self.monthLeadingConstraint = self.solarDate.count;
    [dateFormatter setDateFormat:@"yyyy"];
    year = [[dateFormatter stringFromDate:self.rightTerm] integerValue];
    [dateFormatter setDateFormat:@"MM"];
    month = [[dateFormatter stringFromDate:self.rightTerm] integerValue];
    [dateFormatter setDateFormat:@"dd"];
    day = [[dateFormatter stringFromDate:self.rightTerm] integerValue];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hour = [dateFormatter stringFromDate:self.rightTerm];
    
    self.monthNumber = month;
    [components setYear:year];
    [components setMonth:month];
    for(NSInteger i=1;i<=day;i++){
        [components setDay:i];
        NSDate *date = [calendar dateFromComponents:components];
        [self.solarDate addObject:@(i)];
        TTLunarDate *lunarDate = [TTLunarCalendar convertFromGeneralDate:date];
        [self.lunarDate addObject:lunarDate.lunarDayInChinese];
        
        if(lunarDate.lunarMonth == selectDate.lunarMonth.integerValue &&
           lunarDate.lunarDay == selectDate.lunarDay.integerValue){
            self.indexOfCurrentDay = self.lunarDate.count-1;
        }
    }
    
    //（有时节气时间会超过晚上11点，延顺到下一天）
    if([hour isEqualToString:@"23"]){
        NSInteger rightDayCount = [NSNumber getDayCountWithMonth:month
                                                            year:year];
        if(day<rightDayCount){
            day+=1;
        }
        else{
            day = 1;
            if(month<12){
                month+=1;
            }
            else{
                month = 1;
                year += 1;
            }
        }
        
        [components setYear:self.currentSolarYear];
        [components setMonth:month];
        [components setDay:day];
        NSDate *date = [calendar dateFromComponents:components];
        [self.solarDate addObject:@(day)];
        TTLunarDate *lunarDate = [TTLunarCalendar convertFromGeneralDate:date];
        [self.lunarDate addObject:lunarDate.lunarDayInChinese];
    }
}

@end
