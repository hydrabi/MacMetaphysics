//
//  MainViewModel.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewModel.h"
#import "BottomLocation.h"
#import "TTLunarCalendar.h"
#import "AnalysisSolarTerm.h"
#import "NSString+Addition.h"
#import "NSArray+Addition.h"
#import "BasicViewController.h"
#import <Cocoa/Cocoa.h>

@interface MainViewModel()
@property (nonatomic, assign) Lunar*     lunar;
@end

@implementation MainViewModel

+(instancetype)sharedInstance{
    static MainViewModel *main = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        main = [[MainViewModel alloc] init];
    });
    return main;
}

-(void)initialize{
    [super initialize];
    
    self.leftMenuArr = @[
                         @[
                             @(LeftSideMenuTypeChaoDai),
                             @(LeftSideMenuTypeYanSe),
                             @(LeftSideMenuTypeShenSha),
                             @(LeftSideMenuTypeShuangZao),
                             ],
                         
                         @[
                             @(LeftSideMenuTypeYongShen),
                             @(LeftSideMenuTypeGeJu),
                             @(LeftSideMenuTypeXiangMao),
                             @(LeftSideMenuTypeWenPin),
                             @(LeftSideMenuTypeFuMu),
                             
                             @(LeftSideMenuTypeXiongDi),
                             @(LeftSideMenuTypeZiNv),
                             @(LeftSideMenuTypeHunYin),
                             @(LeftSideMenuTypeGuanGui),
                             @(LeftSideMenuTypeCaiFu),
                             
                             @(LeftSideMenuTypeGuanSi),
                             ]
                         ];
    
    self.stemsStr = [NSString stemsStr];
    self.branchesStr = [NSString branchesStr];
    self.jiaZiArr = [NSArray jiaZiArr];
    
    self.hadShowSolarTermsCollectionView = NO;
    self.hadHiddenBottomTableView = NO;
    self.hiddenBottomTableViewTag = 0;
    
    self.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
    self.currentSelectTopSectionMenuTypeArr = @[].mutableCopy;
    self.shuangZaoData = [[ShuangZaoData alloc] init];
    self.selectedDate = [[CurrentSelectDate alloc] init];
    self.riZhuData = [[RiZhuData alloc] init];
    self.middleData = [[MiddleViewData alloc] init];
    self.bottomData = [[BottomViewData alloc] init];
    self.fifteenYunData = [[FifteenYunData alloc] init];
    self.liuNianData = [[LiuNianData alloc] init];
    self.leftMenuBottomTextData = [[LeftMenuBottomTextData alloc] init];
    self.lunar = new Lunar();
    
    self.solarTermsTimeDic = [AnalysisSolarTerm analysis];
    
    [self bindOperation];
}

-(void)bindOperation{
    self.reloadBottomTablesSig = [[RACSubject subject]
                                  setNameWithFormat:@"tableViewHiddenOperationSig"];
    
    self.leftMenuClickTextViewOperationSig = [[RACSubject subject] setNameWithFormat:@"leftMenuClickTextViewOperationSig"];
    
    self.fifteenYunTextViewOperationSig = [[RACSubject subject] setNameWithFormat:@"fifteenYunTextViewOperationSig"];
    
    self.currentBottomTextViewOperationSig = [[RACSubject subject] setNameWithFormat:@"currentBottomTextViewOperationSig"];
    
    self.reloadLeftTableSig = [[RACSubject subject]
                               setNameWithFormat:@"reloadLeftTableSig"];
    self.leftMenuTopSelectedOperationSig = [[RACSubject subject] setNameWithFormat:@"leftMenuTopSelectedOperationSig"];
    
    self.bottomNoteTextViewOperationSig = [[RACSubject subject] setNameWithFormat:@"bottomTextViewOperationSig"];
}

-(NSString*)getSpecificMenuTitleWithType:(LeftSideMenuType)type{
    NSString *result = @"";
    
    switch (type) {
        case LeftSideMenuTypeChaoDai:
            result = @"朝代";
            break;
        case LeftSideMenuTypeShuangZao:
            result = @"双造";
            break;
        case LeftSideMenuTypeDaYun:
            result = @"大运";
            break;
        case LeftSideMenuTypeYongShen:
            result = @"用神-忌神";
            break;
        case LeftSideMenuTypeGeJu:
            result = @"格局-象意";
            break;
        case LeftSideMenuTypeXiangMao:
            result = @"相貌-性格";
            break;
        case LeftSideMenuTypeWenPin:
            result = @"文凭-特长";
            break;
        case LeftSideMenuTypeFuMu:
            result = @"父母";
            break;
        case LeftSideMenuTypeXiongDi:
            result = @"兄弟";
            break;
        case LeftSideMenuTypeZiNv:
            result = @"子女";
            break;
        case LeftSideMenuTypeHunYin:
            result = @"婚姻";
            break;
        case LeftSideMenuTypeGuanGui:
            result = @"官贵";
            break;
        case LeftSideMenuTypeCaiFu:
            result = @"财富";
            break;
        case LeftSideMenuTypeGuanSi:
            result = @"官司-牢狱";
            break;
        case LeftSideMenuTypeJiBing:
            result = @"疾病-灾祸";
            break;
        case LeftSideMenuTypeYanSe:
            result = @"色●";
            break;
        case LeftSideMenuTypeShenSha:
            result = @"神煞表";
            break;
        case LeftSideMenuTypeCountQiYunUseHour:
            result = @"起运-小时";
            break;
        case LeftSideMenuTypeVersion:
            result = @"04_29";
            break;
            
        default:
            break;
    }
    
    return result;
}

-(LeftSideMenuType)getSpecificMenuTypeWithIndexPath:(NSIndexPath*)indexPath{
    LeftSideMenuType type = LeftSideMenuTypeChaoDai;
    
    if(self.leftMenuArr.count>indexPath.section){
        NSArray *temp = self.leftMenuArr[indexPath.section];
        if(temp.count>indexPath.item){
            type = (LeftSideMenuType)[temp[indexPath.item] integerValue];
        }
    }
    return type;
}

#pragma mark - 隐藏tableView
-(void)hiddenTableViewWithTag:(NSInteger)tag{
    if(self.hiddenBottomTableViewTag != tag){
        self.hiddenBottomTableViewTag = tag;
        self.hadHiddenBottomTableView = YES;
    }
    else{
        self.hadHiddenBottomTableView = !self.hadHiddenBottomTableView;
    }
//    [(RACSubject*)self.reloadBottomTablesSig sendNext:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationKey_groupBottomXiaoYunViewReload
                                                        object:nil];
}

#pragma mark - 选择tableView的某一行
-(void)selectTableViewTag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath{
    
    [self.liuNianData selectTableViewTag:tag
                               indexPath:indexPath];
    
}

#pragma mark - 选择底部大运的某一个，显示15运
-(void)selectTableViewHeaderWithTag:(NSInteger)tag{
    if(self.fifteenYunData.fifteenYunSelectedNumber != tag){
        self.fifteenYunData.fifteenYunSelectedNumber = tag;
        self.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
    }
    else{
        self.fifteenYunData.fifteenYunSelectedNumber = -1;
    }
    [(RACSubject*)self.fifteenYunTextViewOperationSig sendNext:nil];
//    [(RACSubject*)self.reloadBottomTablesSig sendNext:nil];
    [(RACSubject*)self.reloadLeftTableSig sendNext:nil];
}

#pragma mark - 日期转换
-(NSString*)getGanZhiWithYear:(int32_t)year
                        month:(int32_t)month
                          day:(int32_t)day
               middleViewType:(MiddleSubViewType)type{
    if(year>=1900 &&
       year<=2100){
        
        if(month>12){
            month = 1;
            year += 1;
        }
        
        int leapMonth = self.lunar->leapMonth(year);
        struct LunarObj *obj;
        //当前选中的是闰月
        if([self.selectedDate.isLeapMonth boolValue] &&
           self.selectedDate.lunarMonth.integerValue == leapMonth){
            obj = self.lunar->lunar2solar(year,
                                          month,
                                          day,
                                          true);
        }
        else{
            obj = self.lunar->lunar2solar(year,
                                          month,
                                          day,
                                          false);
        }
        
        if(obj != NULL){
            TTLunarDate *date = [[TTLunarDate alloc] initWithLunarObj:obj];
            switch (type) {
                case MiddleSubViewTypeYear:
                {
                    return date.ganzhiYear;
                }
                    break;
                case MiddleSubViewTypeMonth:
                {
                    return date.ganzhiMonth;
                }
                    break;
                case MiddleSubViewTypeDay:
                {
                    return date.ganzhiDay;
                }
                    break;
                default:
                    break;
            }
        }
    }
    return nil;
}

-(void)solarToLunar{
    if(self.selectedDate.gregorianYear.integerValue>=1900 &&
       self.selectedDate.gregorianYear.integerValue<=2100){
        int32_t year = (int32_t)self.selectedDate.gregorianYear.integerValue;
        int32_t month = (int32_t)self.selectedDate.gregorianMonth.integerValue;
        int32_t day = (int32_t)self.selectedDate.gregorianDay.integerValue;
        int32_t hour = (int32_t)self.selectedDate.gregorianHour.integerValue;
        
        //如果为23时
        if(hour == 23){
            day += 1;
            int32_t dayCount = self.lunar->solarDays(year, month);
            if(day>dayCount){
                day = 1;
                month += 1;
            }
            
            if(month>12){
                month = 1;
                year += 1;
            }
        }
        
        struct LunarObj *obj = self.lunar->solar2lunar(year,
                                                       month,
                                                       day);
        if(obj != NULL){
            TTLunarDate *date = [[TTLunarDate alloc] initWithLunarObj:obj];
            self.selectedDate.lunarYear     = @(date.lunarYear);
            self.selectedDate.lunarMonth    = @(date.lunarMonth);
            self.selectedDate.lunarDay      = @(date.lunarDay);
            self.selectedDate.lunarHour     = self.selectedDate.gregorianHour;
            self.selectedDate.isLeapMonth   = @(date.isLeap);
            self.selectedDate.ganZhiYear    = date.ganzhiYear;
            self.selectedDate.ganZhiMonth   = date.ganzhiMonth;
            self.selectedDate.ganZhiDay     = date.ganzhiDay;
            self.selectedDate.ganZhiHour    = [NSString ganZhiHourWithHour:self.selectedDate.lunarHour.integerValue
                                                                       day:self.selectedDate.ganZhiDay];
            [self.riZhuData resetTermWithYear:self.selectedDate.gregorianYear.integerValue];
            self.selectedDate.currentTermName = self.riZhuData.currentTermName;
            
            //转换后的处理
            [self afterTransform];
        }
    }
    
}

-(void)lunarToSolar{
    if(self.selectedDate.lunarYear.integerValue>=1900 &&
       self.selectedDate.lunarYear.integerValue<=2100){
        int leapMonth = self.lunar->leapMonth((int32_t)self.selectedDate.lunarYear.integerValue);
        struct LunarObj *obj;
        //当前选中的是闰月
        if([self.selectedDate.isLeapMonth boolValue] &&
           self.selectedDate.lunarMonth.integerValue == leapMonth){
            obj = self.lunar->lunar2solar((int32_t)self.selectedDate.lunarYear.integerValue,
                                          (int32_t)self.selectedDate.lunarMonth.integerValue,
                                          (int32_t)self.selectedDate.lunarDay.integerValue,
                                          true);
        }
        else{
            obj = self.lunar->lunar2solar((int32_t)self.selectedDate.lunarYear.integerValue,
                                          (int32_t)self.selectedDate.lunarMonth.integerValue,
                                          (int32_t)self.selectedDate.lunarDay.integerValue,
                                          false);
        }
        
        if(obj != NULL){
            TTLunarDate *date = [[TTLunarDate alloc] initWithLunarObj:obj];
            self.selectedDate.gregorianYear     = @(date.solarYear);
            self.selectedDate.gregorianMonth    = @(date.solarMonth);
            self.selectedDate.gregorianDay      = @(date.solarDay);
            self.selectedDate.gregorianHour     = self.selectedDate.lunarHour;
            self.selectedDate.isLeapMonth       = @(date.isLeap);
            self.selectedDate.ganZhiYear        = date.ganzhiYear;
            self.selectedDate.ganZhiMonth       = date.ganzhiMonth;
            self.selectedDate.ganZhiDay         = date.ganzhiDay;
            self.selectedDate.ganZhiHour        = [NSString ganZhiHourWithHour:self.selectedDate.lunarHour.integerValue
                                                                           day:self.selectedDate.ganZhiDay];
            //转换后的处理
            [self afterTransform];
        }
    }
}

-(int32_t)getLeapMonthWithYear:(int32_t)year{
    return self.lunar->leapMonth(year);
}

-(int32_t)getLeapDayWithYear:(int32_t)year{
    return self.lunar->leapDays(year);
}

-(int32_t)getLunarDayWithYear:(int32_t)year month:(int32_t)month{
    return self.lunar->monthDays(year, month);
}

-(NSMutableArray*)getTremWithYear:(int32_t)year{
    int32_t result;
    NSMutableArray *allTerm = @[].mutableCopy;
    for(int32_t i = 1;i<=24;i++){
        result = self.lunar->getTerm(year, i);
        [allTerm addObject:@(result)];
    }
    return  allTerm;
}

/**
 公历转换为农历或者农历转换为公历后的处理工作
 */
-(void)afterTransform{
    [self.riZhuData resetTermWithYear:self.selectedDate.gregorianYear.integerValue];
    self.selectedDate.currentTermName = self.riZhuData.currentTermName;
    
    [self.selectedDate countTaiYuan];
    [self.selectedDate countMingGong];
    [self.middleData resetData];
    [self.bottomData resetData];
    [self.fifteenYunData clearData];
    [self selectTableViewHeaderWithTag:-1];
}

@end
