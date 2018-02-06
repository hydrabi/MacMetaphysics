 //
//  DatePickViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/30.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "DatePickViewController.h"
#import "DatePickViewModel.h"
#import "NSString+Addition.h"

@interface DatePickViewController ()<NSDatePickerCellDelegate>
@property (weak) IBOutlet NSDatePicker *pickView;
@property (nonatomic,strong)DatePickViewModel *viewModel;
@end

@implementation DatePickViewController
@dynamic viewModel;

+(NSPopover*)presentViewControllerWithRect:(NSRect)rect view:(NSViewController<NSPopoverDelegate>*)viewController type:(CalendarType)type{
    
    DatePickViewController *picker = [[DatePickViewController alloc] initWithCalendarType:type];
    picker.view.frame = NSMakeRect(0, 0, datePickerWidth, datePickerHeight);
    NSPopover *popver = [[NSPopover alloc] init];
    popver.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    popver.contentViewController = picker;
    popver.behavior = NSPopoverBehaviorTransient;
    //NSRectEdgeMaxY 下面
    [popver showRelativeToRect:rect ofView:viewController.view preferredEdge:NSRectEdgeMaxY];
    popver.delegate = viewController;
    
    return popver;
}

-(instancetype)initWithCalendarType:(CalendarType)type{
    DatePickViewModel *viewModel = [[DatePickViewModel alloc] init];
    self = [super initWithViewModel:viewModel];
    self.viewModel.calendarType = type;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configPickerRange];
    [self setAppearDate];
}

//假设当前已经有日期 使用当前日期时间
-(void)setAppearDate{
    CurrentSelectDate *selectedDate = [MainViewModel sharedInstance].selectedDate;
    if(selectedDate.gregorianYear){
        NSDate *date = [selectedDate getGregorianDate];
        if(date){
            self.pickView.dateValue = date;
        }
    }
    else{
        self.pickView.dateValue = [NSDate date];
    }
}

-(void)configPickerRange{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1900];
    [components setMonth:1];
    [components setDay:1];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *gregorianMinDate = [gregorian dateFromComponents:components];
    [components setYear:2100];
    NSDate *gregorianMaxDate = [gregorian dateFromComponents:components];
    self.pickView.minDate = gregorianMinDate;
    self.pickView.maxDate = gregorianMaxDate;
}

-(void)getPickViewDate{
    NSDate *currentDate = self.pickView.dateValue;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:currentDate];
    //新历
    if(self.viewModel.calendarType == CalendarTypeGregorian){
        self.viewModel.date.gregorianYear = @(components.year);
        self.viewModel.date.gregorianMonth = @(components.month);
        self.viewModel.date.gregorianDay = @(components.day);
        self.viewModel.date.gregorianHour = @(components.hour);
    }
    else{
        self.viewModel.date.lunarYear = @(components.year);
        self.viewModel.date.lunarMonth = @(components.month);
        self.viewModel.date.lunarDay = @(components.day);
        self.viewModel.date.lunarHour = @(components.hour);
    }
}

@end
