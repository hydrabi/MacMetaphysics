//
//  ShuangZaoData.m
//  Metaphysics
//
//  Created by Hydra on 2017/2/13.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "ShuangZaoData.h"
#import "MainViewModel.h"
#import "NSArray+Addition.h"
#import "NSString+Addition.h"
@implementation ShuangZaoData

-(void)initialize{
    self.year = @"";
    self.day = @"";
}

-(void)setYear:(NSString *)year{
    _year = year;
    if(year.length>0){
        self.month = [NSArray getMonthGanZhiArrWithStems:[self.year getStems]][0];
    }
}

-(void)setDay:(NSString *)day{
    _day = day;
    if(day.length>0){
        self.hour = [NSString ganZhiHourWithHour:0
                                             day:self.day];
    }
}

-(void)resetData{
//    self.mainTitle = @"";
//    self.year = @"";
//    self.month = @"";
//    self.day = @"";
//    self.hour = @"";
//    self.text1 = @"";
//    self.text2 = @"";
}

@end
