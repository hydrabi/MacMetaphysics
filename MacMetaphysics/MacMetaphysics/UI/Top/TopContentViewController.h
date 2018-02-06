//
//  TopContentViewController.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/11.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TopContentViewController : NSViewController<NSTextFieldDelegate,NSPopoverDelegate>

@property (nonatomic,weak)IBOutlet NSButton *hideButton;
@property (nonatomic,weak)IBOutlet NSTextField *firstTextField;
@property (nonatomic,weak)IBOutlet NSTextField *secondTextField;
@property (nonatomic,weak)IBOutlet NSTextField *thirdTextField;
//农历选择按钮
@property (nonatomic,weak)IBOutlet NSButton *lunarCalendarSelectedButton;
//公历选择按钮
@property (nonatomic,weak)IBOutlet NSButton *gregorianCalendarSelectedButton;
//公历年
@property (nonatomic,weak)IBOutlet NSTextField *gregorianYearTxt;
//公历月
@property (nonatomic,weak)IBOutlet NSTextField *gregorianMonthTxt;
//公历日
@property (nonatomic,weak)IBOutlet NSTextField *gregorianDayTxt;
//公历时
@property (nonatomic,weak)IBOutlet NSTextField *gregorianHourTxt;
//农历年
@property (nonatomic,weak)IBOutlet NSTextField *lunarYearTxt;
//农历月
@property (nonatomic,weak)IBOutlet NSTextField *lunarMonthTxt;
//农历日
@property (nonatomic,weak)IBOutlet NSTextField *lunarDayTxt;
//农历时
@property (nonatomic,weak)IBOutlet NSTextField *lunarHourTxt;
//是否闰月
@property (nonatomic,weak)IBOutlet NSTextField *leapMonthLabel;
//节气
@property (nonatomic,weak)IBOutlet NSTextField *solarTermsLabel;
//胎元
@property (nonatomic,weak)IBOutlet NSTextField *taiYuanLabel;
//命宫
@property (nonatomic,weak)IBOutlet NSTextField *mingGongLabel;

@end
