//
//  CurrentSelectDate.m
//  Metaphysics
//
//  Created by Hydra on 2017/2/16.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "CurrentSelectDate.h"
#import "NSString+Addition.h"
#import "NSArray+Addition.h"
#import "MainViewModel.h"
#import "NSNumber+Addition.h"
@implementation CurrentSelectDate

-(NSDate*)getGregorianDate{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [components setYear:[self.gregorianYear integerValue]];
    [components setMonth:[self.gregorianMonth integerValue]];
    [components setDay:[self.gregorianDay integerValue]];
    [components setHour:[self.gregorianHour integerValue]];
    [components setMinute:0];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

//胎元,即出生月的天干进一位、地支进三位
-(void)countTaiYuan{
    if(self.ganZhiMonth.length>0){
        NSString *monthStems = [self.ganZhiMonth getStems];
        NSString *monthBranches = [self.ganZhiMonth getBranches];
        NSInteger stemsIndex = [[NSString stemsStr] rangeOfString:monthStems].location;
        NSInteger branchesIndex = [[NSString branchesStr] rangeOfString:monthBranches].location;
        
        stemsIndex += 1;
        if(stemsIndex >= [NSString stemsStr].length){
            stemsIndex -= [NSString stemsStr].length;
        }
        
        branchesIndex += 3;
        if(branchesIndex >= [NSString branchesStr].length){
            branchesIndex -= [NSString branchesStr].length;
        }
        
        NSString *stemsResult = [[NSString stemsStr] substringWithRange:NSMakeRange(stemsIndex,
                                                                                    1)];
        NSString *branchesResult = [[NSString branchesStr] substringWithRange:NSMakeRange(branchesIndex,
                                                                                          1)];
        self.taiYuan = [NSString stringWithFormat:@"%@%@",stemsResult,branchesResult];
    }
}

/*凡推命宫，须以生月之数（如过中气，作次月之数推。）与生时之数合算。寅一，卯二，辰三，巳四，午五，未六，申七，酉八，戌九，亥十，子十一，丑十二，以十四为本位。如月之数不满十四当加之，加到十四为止。即以所加之数，为某宫。如满十四数者。当加至二十六，为本位。亦以所加之数为某宫。或以十四减去月令时辰之总和，所余之数，即为命宫。欲知某宫之干，再以年干遁之。与年上起月法同。列式如下：
14-(月令（过候加一）+时辰)=命宫
26-(月令（过候加一）+时辰)=命宫*/
-(void)countMingGong{
    NSArray *mingGongShuArr = @[@(11),
                                @(12),
                                @(1),
                                @(2),
                                @(3),
                                @(4),
                                @(5),
                                @(6),
                                @(7),
                                @(8),
                                @(9),
                                @(10),];
    
    NSString *ganZhiYear = self.ganZhiYear;
    NSString *ganZhiMonth = self.ganZhiMonth;
    NSString *ganZhiHour = self.ganZhiHour;
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    
    //过中气的月份加一
    if([[NSArray zhongQiArr] containsObject:self.currentTermName]){
        
        ganZhiMonth = [mainViewModel getGanZhiWithYear:(int32_t)self.lunarYear.integerValue
                                                 month:(int32_t)(self.lunarMonth.integerValue+1)
                                                   day:(int32_t)self.lunarDay.integerValue
                                        middleViewType:MiddleSubViewTypeMonth];
    }
    
    if(ganZhiMonth){
        NSString *monthBranches = [ganZhiMonth getBranches];
        NSInteger monthBranchesIndex = [[NSString branchesStr] rangeOfString:monthBranches].location;
        NSInteger monthMingGongNumber = [mingGongShuArr[monthBranchesIndex] integerValue];
        
        NSString *hourBranches = [ganZhiHour getBranches];
        NSInteger hourBranchesIndex = [[NSString branchesStr] rangeOfString:hourBranches].location;
        NSInteger hourMingGongNumber = [mingGongShuArr[hourBranchesIndex] integerValue];
        
        NSInteger total = monthMingGongNumber + hourMingGongNumber;
        NSInteger left = 0;
        if(total < 14){
            left = 14 - total;
        }
        else{
            left = 26 - total;
        }
        
        //命宫的支
        NSString *resultBranches = [[NSString branchesStr] substringWithRange:NSMakeRange([mingGongShuArr indexOfObject:@(left)],
                                                                                          1)];
        NSArray *monthGanZhiArr= [NSArray getMonthGanZhiArrWithStems:[ganZhiYear getStems]];
        for (NSString *ganZhi in monthGanZhiArr){
            if([[ganZhi getBranches] isEqualToString:resultBranches]){
                self.mingGong = ganZhi;
                break;
            }
        }
    }
    
}

#pragma mark - 年 1900-2100
-(void)resetLunarYearWithIncrease:(BOOL)increase{
    if(increase){
        if(self.lunarYear.integerValue < 2100){
            if(self.lunarYear.integerValue < 1900){
                self.lunarYear = @(1900);
            }
            else{
                self.lunarYear = @(self.lunarYear.integerValue + 1);
            }
        }
        else{
            self.lunarYear = @(1900);
        }
    }
    else{
        if(self.lunarYear.integerValue > 1900){
            self.lunarYear = @(self.lunarYear.integerValue - 1);
        }
        else{
            self.lunarYear = @(2100);
        }
    }
}

-(void)resetGregorianYearWithIncrease:(BOOL)increase{
    if(increase){
        if(self.gregorianYear.integerValue < 2100){
            if(self.gregorianYear.integerValue <1900){
                self.gregorianYear = @(1900);
            }
            else{
                self.gregorianYear = @(self.gregorianYear.integerValue + 1);
            }
            
        }
        else{
            self.gregorianYear = @(1900);
        }
    }
    else{
        if(self.gregorianYear.integerValue > 1900){
            self.gregorianYear = @(self.gregorianYear.integerValue - 1);
        }
        else{
            self.gregorianYear = @(2100);
        }
    }
    
    [self adjustDayIfBeyondMaxDay];
}

#pragma mark - 月
-(void)resetLunarMonthWithIncrease:(BOOL)increase{
    if(increase){
        if(self.lunarMonth.integerValue < 12){
            self.lunarMonth = @(self.lunarMonth.integerValue + 1);
        }
        else{
            self.lunarMonth = @(1);
        }
    }
    else{
        if(self.lunarMonth.integerValue > 1){
            self.lunarMonth = @(self.lunarMonth.integerValue - 1);
        }
        else{
            self.lunarMonth = @(12);
        }
    }
}

-(void)resetGregorianMonthWithIncrease:(BOOL)increase{
    if(increase){
        if(self.gregorianMonth.integerValue < 12){
            self.gregorianMonth = @(self.gregorianMonth.integerValue + 1);
        }
        else{
            self.gregorianMonth = @(1);
            [self resetGregorianYearWithIncrease:YES];
        }
    }
    else{
        if(self.gregorianMonth.integerValue > 1){
            self.gregorianMonth = @(self.gregorianMonth.integerValue - 1);
        }
        else{
            self.gregorianMonth = @(12);
            [self resetGregorianYearWithIncrease:NO];
        }
    }
    
    [self adjustDayIfBeyondMaxDay];
}

#pragma mark - 日
-(void)resetLunarDayWithIncrease:(BOOL)increase{
    if(increase){
        //农历最多30日每月
        if(self.lunarDay.integerValue < 30){
            self.lunarDay = @(self.lunarDay.integerValue + 1);
        }
        else{
            self.lunarDay = @(1);
        }
    }
    else{
        if(self.lunarDay.integerValue > 1){
            self.lunarDay = @(self.lunarDay.integerValue - 1);
        }
        else{
            self.lunarDay = @(30);
        }
    }
}

-(void)resetGregorianDayWithIncrease:(BOOL)increase{
    NSInteger dayCount = 31;
    
    //如果新历月份和年份都不为空不为空
    if(self.gregorianMonth &&
       self.gregorianYear){
        dayCount = [NSNumber getDayCountWithMonth:self.gregorianMonth.integerValue
                                             year:self.gregorianYear.integerValue];
    }
    
    if(increase){
        
        //新历最多31日每月
        if(self.gregorianDay.integerValue < dayCount){
            self.gregorianDay = @(self.gregorianDay.integerValue + 1);
        }
        else{
            self.gregorianDay = @(1);
            [self resetGregorianMonthWithIncrease:YES];
        }
    }
    else{
        if(self.gregorianDay.integerValue > 1){
            self.gregorianDay = @(self.gregorianDay.integerValue - 1);
        }
        else{
            self.gregorianDay = @(dayCount);
            [self resetGregorianMonthWithIncrease:NO];
        }
    }
}

#pragma mark - 时
-(void)resetLunarHourWithIncrease:(BOOL)increase{
    if(increase){
        if(self.lunarHour.integerValue < 23){
            self.lunarHour = @(self.lunarHour.integerValue + 1);
        }
        else{
            self.lunarHour = @(0);
        }
    }
    else{
        if(self.lunarHour.integerValue > 0){
            self.lunarHour = @(self.lunarHour.integerValue - 1);
        }
        else{
            self.lunarHour = @(23);
        }
    }
}

-(void)resetGregorianHourWithIncrease:(BOOL)increase{
    if(increase){
        if(self.gregorianHour.integerValue < 23){
            self.gregorianHour = @(self.gregorianHour.integerValue + 1);
        }
        else{
            self.gregorianHour = @(0);
            [self resetGregorianDayWithIncrease:YES];
        }
    }
    else{
        if(self.gregorianHour.integerValue > 0){
            self.gregorianHour = @(self.gregorianHour.integerValue - 1);
        }
        else{
            self.gregorianHour = @(23);
            [self resetGregorianDayWithIncrease:NO];
        }
    }
}

#pragma mark - 调整月份，或者年份时，判断日数是否超过了最大值
-(void)adjustDayIfBeyondMaxDay{
    NSInteger dayCount = 31;
    
    //如果新历月份和年份都不为空不为空
    if(self.gregorianMonth &&
       self.gregorianYear){
        dayCount = [NSNumber getDayCountWithMonth:self.gregorianMonth.integerValue
                                             year:self.gregorianYear.integerValue];
    }
    
    if(self.gregorianDay.integerValue > dayCount){
        self.gregorianDay = @(dayCount);
    }
}

@end
