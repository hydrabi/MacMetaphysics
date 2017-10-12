//
//  NSArray+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/11.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSArray+Addition.h"
#import "NSString+Addition.h"
@implementation NSArray (Addition)

+(NSMutableArray*)jiaZiArr{
    NSString *stemsStr = [NSString stemsStr];
    NSString *branchesStr = [NSString branchesStr];
    NSMutableArray *arr = @[].mutableCopy;
    NSInteger i = 0;
    NSInteger j = 0;
    for(NSInteger index = 0; index < 60; index++){
        NSString *stem = [stemsStr substringWithRange:NSMakeRange(i, 1)];
        NSString *branch = [branchesStr substringWithRange:NSMakeRange(j, 1)];
        NSString *jiaZi = [NSString stringWithFormat:@"%@%@",stem,branch];
        [arr addObject:jiaZi];
        
        i++;
        j++;
        if(i == stemsStr.length){
            i = 0;
        }
        
        if(j==branchesStr.length){
            j = 0;
        }
    }
    return arr;
}

+(NSArray*)termsNameArr{
    return @[@"小寒",
             @"大寒",
             @"立春",
             @"雨水",
             @"惊蛰",
             @"春分",
             @"清明",
             @"谷雨",
             @"立夏",
             @"小满",
             @"芒种",
             @"夏至",
             @"小暑",
             @"大暑",
             @"立秋",
             @"处暑",
             @"白露",
             @"秋分",
             @"寒露",
             @"霜降",
             @"立冬",
             @"小雪",
             @"大雪",
             @"冬至"];
}

+(NSArray*)monthNameArr{
    return @[
             @"丑月",
             @"寅月",
             @"卯月",
             @"辰月",
             @"巳月",
             @"午月",
             @"未月",
             @"申月",
             @"酉月",
             @"戌月",
             @"亥月",
             @"子月",
             ];
}

//寅月： 戊7日    丙7日    甲16日
//卯月：         甲10日    乙20日
//辰月： 乙9日    癸3日    戊18日
//巳月： 戊5日    庚9日    丙16日
//午月：丙10日    己9日    丁11日
//未月： 丁9日    乙3日    己18日
//申月：戊10日    壬3日    庚17日
//酉月：         庚10日    辛20日
//戌月： 辛9日    丁3日    戊18日
//亥月： 戊7日    甲5日    壬18日
//子月：         壬10日    癸20日
//丑月： 癸9日    辛3日    己18日
+(NSArray*)separatorDayWithMonth:(NSInteger)month{
    NSArray *separatorDayArr = nil;
    switch (month) {
        case 0:
        {
            //丑月
            separatorDayArr = @[@(9),
                                @(3),
                                @(18)];
        }
            break;
        case 1:
        {
            //寅月
            separatorDayArr = @[@(7),
                                @(7),
                                @(16)];
        }
            break;
        case 2:
        {
            //卯月
            separatorDayArr = @[@(10),
                                @(20),
                                ];
        }
            break;
        case 3:
        {
            //辰月
            separatorDayArr = @[@(9),
                                @(3),
                                @(18)
                                ];
        }
            break;
        case 4:
        {
            //巳月
            separatorDayArr = @[@(5),
                                @(9),
                                @(16)
                                ];
        }
            break;
        case 5:
        {
            //午月
            separatorDayArr = @[@(10),
                                @(9),
                                @(11)
                                ];
        }
            break;
        case 6:
        {
            //未月
            separatorDayArr = @[@(9),
                                @(3),
                                @(18)
                                ];
        }
            break;
        case 7:
        {
            //申月
            separatorDayArr = @[@(10),
                                @(3),
                                @(17)
                                ];
        }
            break;
        case 8:
        {
            //酉月
            separatorDayArr = @[@(10),
                                @(20),
                                ];
        }
            break;
        case 9:
        {
            //戌月
            separatorDayArr = @[@(9),
                                @(3),
                                @(18),
                                ];
        }
            break;
        case 10:
        {
            //亥月
            separatorDayArr = @[@(7),
                                @(5),
                                @(18),
                                ];
        }
            break;
        case 11:
        {
            //子月
            separatorDayArr = @[@(10),
                                @(20),
                                ];
        }
            break;
            
        default:
            break;
    }
    return separatorDayArr;
}

+(NSArray*)separatorDayNameWithMonth:(NSInteger)month{
    NSArray *separatorDayArr = nil;
    switch (month) {
        case 0:
        {
            //丑月
            separatorDayArr = @[@"癸9日",
                                @"辛3日",
                                @"己18日"];
        }
            break;
        case 1:
        {
            //寅月
            separatorDayArr = @[@"戊7日",
                                @"丙7日",
                                @"甲16日"];
        }
            break;
        case 2:
        {
            //卯月
            separatorDayArr = @[@"甲10日",
                                @"乙20日"];
        }
            break;
        case 3:
        {
            //辰月
            separatorDayArr = @[@"乙9日",
                                @"癸3日",
                                @"戊18日"];
        }
            break;
        case 4:
        {
            //巳月
            separatorDayArr = @[@"戊5日",
                                @"庚9日",
                                @"丙16日"];
        }
            break;
        case 5:
        {
            //午月
            separatorDayArr = @[@"丙10日",
                                @"己9日",
                                @"丁11日"];
        }
            break;
        case 6:
        {
            //未月
            separatorDayArr = @[@"丁9日",
                                @"乙3日",
                                @"己18日"];
        }
            break;
        case 7:
        {
            //申月
            separatorDayArr = @[@"戊10日",
                                @"壬3日",
                                @"庚17日"];
        }
            break;
        case 8:
        {
            //酉月
            separatorDayArr = @[@"庚10日",
                                @"辛20日",
                                ];
        }
            break;
        case 9:
        {
            //戌月
            separatorDayArr = @[@"辛9日",
                                @"丁3日",
                                @"戊18日"];
        }
            break;
        case 10:
        {
            //亥月
            separatorDayArr = @[@"戊7日",
                                @"甲5日",
                                @"壬18日"];
        }
            break;
        case 11:
        {
            //子月
            separatorDayArr = @[@"壬10日",
                                @"癸20日",
                                ];
        }
            break;
            
        default:
            break;
    }
    return separatorDayArr;
}

+(NSMutableArray*)allTermsDateArrWithYear:(NSInteger)year solarTermTimeArr:(NSArray*)solarTermTimeArr termsDate:(NSMutableArray*)termsDate{
    NSMutableArray *resultArr = @[].mutableCopy;
    NSInteger month;
    NSInteger day;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    for(NSInteger i = 0;i<termsDate.count;i++){
        month = (NSInteger)((i/2)+1);
        day = [termsDate[i] integerValue];
        NSString *time = solarTermTimeArr[i];
        NSString *hour = [time substringWithRange:NSMakeRange(0, 2)];
        NSString *minute = [time substringWithRange:NSMakeRange(3, 2)];
        [components setYear:year];
        [components setMonth:month];
        [components setDay:day];
        [components setHour:hour.integerValue];
        [components setMinute:minute.integerValue];
        NSDate *date = [calendar dateFromComponents:components];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
        NSLog(@"now:%@", [dateFormatter stringFromDate:date]);
        [resultArr addObject:date];
    }
    return resultArr;
}

+(NSArray*)cangGanArray{
    return @[@"癸",
             @"癸辛己",
             @"戊丙甲",
             @"乙",
             @"乙癸戊",
             @"戊庚丙",
             @"己丁",
             @"丁乙己",
             @"戊壬庚",
             @"辛",
             @"辛丁戊",
             @"甲壬",];
}

+(NSArray*)naYinArray{
    return @[@"海中金",
             @"炉中火",
             @"大林木",
             @"路旁土",
             @"剑锋金",
             @"山头火",
             @"洞下水",
             @"城墙土",
             @"白腊金",
             @"杨柳木",
             @"泉中水",
             @"屋上土",
             @"霹雷火",
             @"松柏木",
             @"长流水",
             @"沙中金",
             @"山下火",
             @"平地木",
             @"壁上土",
             @"金箔金",
             @"佛灯火",
             @"天河水",
             @"大驿土",
             @"钗钏金",
             @"桑松木",
             @"大溪水",
             @"沙中土",
             @"天上火",
             @"石榴木",
             @"大海水",];
}

+(NSArray*)getLiuQinArrWithIndex:(NSInteger)index{
    NSArray *result = nil;
    switch (index) {
        case 0:
        {
            result = @[@(liuQinType_Bi),
                       @(liuQinType_Jie),
                       @(liuQinType_Shi),
                       @(liuQinType_Shang),
                       @(liuQinType_CaiFu),
                       @(liuQinType_CaiHua),
                       @(liuQinType_Sha),
                       @(liuQinType_Guan),
                       @(liuQinType_Xiao),
                       @(liuQinType_Yin),];
        }
            break;
        case 1:
        {
            result = @[@(liuQinType_Jie),
                       @(liuQinType_Bi),
                       @(liuQinType_Shang),
                       @(liuQinType_Shi),
                       @(liuQinType_CaiHua),
                       @(liuQinType_CaiFu),
                       @(liuQinType_Guan),
                       @(liuQinType_Sha),
                       @(liuQinType_Yin),
                       @(liuQinType_Xiao),];
        }
            break;
        case 2:
        {
            result = @[@(liuQinType_Xiao),
                       @(liuQinType_Yin),
                       @(liuQinType_Bi),
                       @(liuQinType_Jie),
                       @(liuQinType_Shi),
                       @(liuQinType_Shang),
                       @(liuQinType_CaiFu),
                       @(liuQinType_CaiHua),
                       @(liuQinType_Sha),
                       @(liuQinType_Guan),];
        }
            break;
        case 3:
        {
            result = @[@(liuQinType_Yin),
                       @(liuQinType_Xiao),
                       @(liuQinType_Jie),
                       @(liuQinType_Bi),
                       @(liuQinType_Shang),
                       @(liuQinType_Shi),
                       @(liuQinType_CaiHua),
                       @(liuQinType_CaiFu),
                       @(liuQinType_Guan),
                       @(liuQinType_Sha),];
        }
            break;
        case 4:
        {
            result = @[@(liuQinType_Sha),
                       @(liuQinType_Guan),
                       @(liuQinType_Xiao),
                       @(liuQinType_Yin),
                       @(liuQinType_Bi),
                       @(liuQinType_Jie),
                       @(liuQinType_Shi),
                       @(liuQinType_Shang),
                       @(liuQinType_CaiFu),
                       @(liuQinType_CaiHua),];
        }
            break;
        case 5:
        {
            result = @[@(liuQinType_Guan),
                       @(liuQinType_Sha),
                       @(liuQinType_Yin),
                       @(liuQinType_Xiao),
                       @(liuQinType_Jie),
                       @(liuQinType_Bi),
                       @(liuQinType_Shang),
                       @(liuQinType_Shi),
                       @(liuQinType_CaiHua),
                       @(liuQinType_CaiFu),];
        }
            break;
        case 6:
        {
            result = @[@(liuQinType_CaiFu),
                       @(liuQinType_CaiHua),
                       @(liuQinType_Sha),
                       @(liuQinType_Guan),
                       @(liuQinType_Xiao),
                       @(liuQinType_Yin),
                       @(liuQinType_Bi),
                       @(liuQinType_Jie),
                       @(liuQinType_Shi),
                       @(liuQinType_Shang),];
        }
            break;
        case 7:
        {
            result = @[@(liuQinType_CaiHua),
                       @(liuQinType_CaiFu),
                       @(liuQinType_Guan),
                       @(liuQinType_Sha),
                       @(liuQinType_Yin),
                       @(liuQinType_Xiao),
                       @(liuQinType_Jie),
                       @(liuQinType_Bi),
                       @(liuQinType_Shang),
                       @(liuQinType_Shi),];
        }
            break;
        case 8:
        {
            result = @[@(liuQinType_Shi),
                       @(liuQinType_Shang),
                       @(liuQinType_CaiFu),
                       @(liuQinType_CaiHua),
                       @(liuQinType_Sha),
                       @(liuQinType_Guan),
                       @(liuQinType_Xiao),
                       @(liuQinType_Yin),
                       @(liuQinType_Bi),
                       @(liuQinType_Jie),];
        }
            break;
        case 9:
        {
            result = @[@(liuQinType_Shang),
                       @(liuQinType_Shi),
                       @(liuQinType_CaiHua),
                       @(liuQinType_CaiFu),
                       @(liuQinType_Guan),
                       @(liuQinType_Sha),
                       @(liuQinType_Yin),
                       @(liuQinType_Xiao),
                       @(liuQinType_Jie),
                       @(liuQinType_Bi),];
        }
            break;
            
        default:
            break;
    }
    return result;
}

+(NSArray*)getMonthGanZhiArrWithStems:(NSString*)stems{
    if([stems isEqualToString:@"甲"] ||
       [stems isEqualToString:@"己"]){
        return @[@"丙寅",
                 @"丁卯",
                 @"戊辰",
                 @"己巳",
                 @"庚午",
                 @"辛未",
                 @"壬申",
                 @"癸酉",
                 @"甲戌",
                 @"乙亥",
                 @"丙子",
                 @"丁丑",];
    }
    else if([stems isEqualToString:@"乙"] ||
            [stems isEqualToString:@"庚"]){
        return @[@"戊寅",
                 @"己卯",
                 @"庚辰",
                 @"辛巳",
                 @"壬午",
                 @"癸未",
                 @"甲申",
                 @"乙酉",
                 @"丙戌",
                 @"丁亥",
                 @"戊子",
                 @"己丑",];
    }
    else if([stems isEqualToString:@"丙"] ||
            [stems isEqualToString:@"辛"]){
        return @[@"庚寅",
                 @"辛卯",
                 @"壬辰",
                 @"癸巳",
                 @"甲午",
                 @"乙未",
                 @"丙申",
                 @"丁酉",
                 @"戊戌",
                 @"己亥",
                 @"庚子",
                 @"辛丑",];
    }
    else if([stems isEqualToString:@"丁"] ||
            [stems isEqualToString:@"壬"]){
        return @[@"壬寅",
                 @"癸卯",
                 @"甲辰",
                 @"乙巳",
                 @"丙午",
                 @"丁未",
                 @"戊申",
                 @"己酉",
                 @"庚戌",
                 @"辛亥",
                 @"壬子",
                 @"癸丑",];
    }
    else {
        return @[@"甲寅",
                 @"乙卯",
                 @"丙辰",
                 @"丁巳",
                 @"戊午",
                 @"己未",
                 @"庚申",
                 @"辛酉",
                 @"壬戌",
                 @"癸亥",
                 @"甲子",
                 @"乙丑",];
    }
}

+(NSArray*)zhongQiArr{
    return @[@"雨水",
             @"春分",
             @"谷雨",
             @"小满",
             @"夏至",
             @"大暑",
             @"处暑",
             @"秋分",
             @"霜降",
             @"小雪",
             @"冬至",
             @"大寒",];
}

@end
