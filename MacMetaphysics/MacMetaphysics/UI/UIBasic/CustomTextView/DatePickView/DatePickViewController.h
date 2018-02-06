//
//  DatePickViewController.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/30.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicViewController.h"
#import "UIConstantParameter.h"
@interface DatePickViewController : BasicViewController
+(NSPopover*)presentViewControllerWithRect:(NSRect)rect view:(NSViewController<NSPopoverDelegate>*)view type:(CalendarType)type;
-(instancetype)initWithCalendarType:(CalendarType)type;
-(void)getPickViewDate;
@end
