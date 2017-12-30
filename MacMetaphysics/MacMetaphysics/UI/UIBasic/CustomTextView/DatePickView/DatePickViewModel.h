//
//  DatePickViewModel.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/30.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicViewModel.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
@interface DatePickViewModel : BasicViewModel
@property (nonatomic,assign)CalendarType calendarType;
@property (nonatomic,strong)NSMutableArray *yearsArr;
@property (nonatomic,strong)NSMutableArray *monthsArr;
@property (nonatomic,strong)NSMutableArray *daysArr;
@property (nonatomic,strong)NSMutableArray *hoursArr;
@property (nonatomic,weak)CurrentSelectDate *date;
//选择了闰月
@property (nonatomic,assign)NSInteger leapMonth;
-(void)createYearsArr;
-(void)createMonthsArr;
-(void)createDaysArr;
-(void)createHoursArr;
@end
