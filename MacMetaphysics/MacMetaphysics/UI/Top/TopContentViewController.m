//
//  TopContentViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/11.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "TopContentViewController.h"
#import "UIConstantParameter.h"
#import "DatePickViewController.h"
#import "MainViewModel.h"
#import "DatePickViewModel.h"
#import "NSString+Addition.h"
@interface TopContentViewController ()
@property (nonatomic,weak)CurrentSelectDate *date;
@end

@implementation TopContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self attributeConfig];
    // Do view setup here.
}

//配置属性
-(void)attributeConfig{
    [self.hideButton setTitle:@"●"];
    [self.hideButton setFont:[NSFont systemFontOfSize:titleFontSize_16]];
    
    self.gregorianYearTxt.delegate = self;
    self.gregorianMonthTxt.delegate = self;
    self.gregorianDayTxt.delegate = self;
    self.gregorianHourTxt.delegate = self;
    self.lunarYearTxt.delegate = self;
    self.lunarMonthTxt.delegate = self;
    self.lunarDayTxt.delegate = self;
    self.lunarHourTxt.delegate = self;
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    self.date = [MainViewModel sharedInstance].selectedDate;
    return [super awakeAfterUsingCoder:aDecoder];
}

-(void)bindViewModel{
    CurrentSelectDate *date = [MainViewModel sharedInstance].selectedDate;
    @weakify(self)
    [[[RACSignal combineLatest:@[RACObserve(date, gregorianYear),
                                 RACObserve(date, gregorianMonth),
                                 RACObserve(date, gregorianDay),
                                 RACObserve(date, gregorianHour),
                                 RACObserve(date, isLeapMonth)] reduce:^id(NSNumber *year,
                                                                           NSNumber *month,
                                                                           NSNumber *day,
                                                                           NSNumber *hour,
                                                                           NSNumber *isLeapMonth){
                                     return nil;
                                 }]
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self resetGregorianValue];
     }];
    
    [[[RACSignal combineLatest:@[RACObserve(date, lunarYear),
                                 RACObserve(date, lunarMonth),
                                 RACObserve(date, lunarDay),
                                 RACObserve(date, lunarHour),
                                 RACObserve(date, isLeapMonth)] reduce:^id(NSNumber *year,
                                                                           NSNumber *month,
                                                                           NSNumber *day,
                                                                           NSNumber *hour,
                                                                           NSNumber *isLeapMonth){
                                     
                                     return nil;
                                 }]
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self resetLunarValue];
     }];
    
    [[RACObserve(date, currentTermName)
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         self.solarTermsLabel.text = self.date.currentTermName;
     }];
    
    //新历
    [[self.gregorianYearTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.gregorianYear = @([text integerValue]);
             [self shouldTransformTolunar];
         }
     }];
    
    [[self.gregorianMonthTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.gregorianMonth = @([text integerValue]);
             [self shouldTransformTolunar];
         }
     }];
    
    [[self.gregorianDayTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.gregorianDay = @([text integerValue]);
             [self shouldTransformTolunar];
         }
     }];
    
    [[self.gregorianHourTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.gregorianHour = @([text integerValue]);
             [self shouldTransformTolunar];
         }
     }];
    
    //农历
    [[self.lunarYearTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.lunarYear = @([text integerValue]);
             [self shouldTransformToSolur];
         }
     }];
    
    [[self.lunarMonthTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.lunarMonth = @([text integerValue]);
             [self shouldTransformToSolur];
         }
     }];
    
    [[self.lunarDayTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.lunarDay = @([text integerValue]);
             [self shouldTransformToSolur];
         }
     }];
    
    [[self.lunarHourTxt.rac_textSignal
      deliverOnMainThread]
     subscribeNext:^(NSString *text){
         @strongify(self)
         if(text.length>0){
             date.lunarHour = @([text integerValue]);
             [self shouldTransformToSolur];
         }
     }];
    
    [[[self rac_signalForSelector:@selector(popoverControllerDidDismissPopover:)
                     fromProtocol:@protocol(UIPopoverControllerDelegate)]
      deliverOnMainThread]
     subscribeNext:^(RACTuple *tuple){
         @strongify(self)
         UIPopoverController *pop = (UIPopoverController*)tuple.first;
         DatePickViewController *controller = (DatePickViewController*)(pop.contentViewController);
         DatePickViewModel *model = (DatePickViewModel*)controller.viewModel;
         //新历
         if(model.calendarType == CalendarTypeGregorian){
             [self shouldTransformTolunar];
         }
         else{
             [self shouldTransformToSolur];
         }
     }];
    
    [[[date rac_signalForSelector:@selector(countTaiYuan)]
      merge:[date rac_signalForSelector:@selector(countMingGong)]]
     subscribeNext:^(id _){
         @strongify(self)
         [self resetTaiYuanMingGong];
     }];
}

//是否足够条件需要转换为农历
-(void)shouldTransformTolunar{
    CurrentSelectDate *date = [MainViewModel sharedInstance].selectedDate;
    if(date.gregorianYear &&
       date.gregorianMonth &&
       date.gregorianDay &&
       date.gregorianHour){
        [[MainViewModel sharedInstance] solarToLunar];
    }
}

//是否足够条件需要转换为新历
-(void)shouldTransformToSolur{
    CurrentSelectDate *date = [MainViewModel sharedInstance].selectedDate;
    if(date.lunarYear &&
       date.lunarMonth &&
       date.lunarDay &&
       date.lunarHour){
        [[MainViewModel sharedInstance] lunarToSolar];
    }
}

//重置公历
-(void)resetGregorianValue{
    self.gregorianYearTxt.text = [self.date.gregorianYear stringValue].length>0?[self.date.gregorianYear stringValue]:@"";
    self.gregorianMonthTxt.text = [self.date.gregorianMonth stringValue].length>0?[self.date.gregorianMonth stringValue]:@"";
    self.gregorianDayTxt.text = [self.date.gregorianDay stringValue].length>0?[self.date.gregorianDay stringValue]:@"";
    self.gregorianHourTxt.text = [self.date.gregorianHour stringValue].length>0?[self.date.gregorianHour stringValue]:@"";
    [self shouldShowLeapMonth];
}

//重置农历
-(void)resetLunarValue{
    self.lunarYearTxt.text = [self.date.lunarYear stringValue].length>0?[self.date.lunarYear stringValue]:@"";
    self.lunarMonthTxt.text = [self.date.lunarMonth stringValue].length>0?[self.date.lunarMonth stringValue]:@"";
    self.lunarDayTxt.text = [self.date.lunarDay stringValue].length>0?[self.date.lunarDay stringValue]:@"";
    self.lunarHourTxt.text = [self.date.lunarHour stringValue].length>0?[NSString shiChenWithTime:self.date.lunarHour.integerValue]:@"";
    [self shouldShowLeapMonth];
}

-(void)shouldShowLeapMonth{
    //判断是否闰月
    if([[MainViewModel sharedInstance] selectedDate].isLeapMonth.boolValue){
        self.leapMonthLabel.hidden = NO;
    }
    else{
        self.leapMonthLabel.hidden = YES;
    }
}

//更新胎元命宫
-(void)resetTaiYuanMingGong{
    self.taiYuanLabel.text = self.date.taiYuan;
    self.mingGongLabel.text = self.date.mingGong;
}

#pragma mark - 点击操作
-(IBAction)hideButtonClickAction{
    self.firstTextField.hidden = !self.firstTextField.hidden;
}

//农历选择
-(IBAction)lunarCalendarSelecteAction:(UIButton*)sender{
    self.popover = [DatePickViewController presentViewControllerWithRect:sender.frame
                                                                    view:self
                                                                    type:CalendarTypeLunar];
}

//公历选择
-(IBAction)gregorianCalendarSelecteAction:(UIButton*)sender{
    self.popover = [DatePickViewController presentViewControllerWithRect:sender.frame
                                                                    view:self
                                                                    type:CalendarTypeGregorian];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == self.gregorianYearTxt ||
       textField == self.lunarYearTxt){
        NSString *completeStr = [textField.text stringByReplacingCharactersInRange:range
                                                                        withString:string];
        if(completeStr.length>4){
            return NO;
        }
        if(string.length>0){
            unichar single = [string characterAtIndex:0];
            if(single >= '0' && single <= '9'){
                return YES;
            }
        }
        else{
            return YES;
        }
    }
    else if(textField == self.gregorianMonthTxt ||
            textField == self.lunarMonthTxt){
        NSString *completeStr = [textField.text stringByReplacingCharactersInRange:range
                                                                        withString:string];
        if(completeStr.length>2){
            return NO;
        }
        
        if([completeStr integerValue]>12){
            return NO;
        }
        
        if(string.length>0){
            unichar single = [string characterAtIndex:0];
            if(single >= '0' && single <= '9'){
                return YES;
            }
        }
        else{
            return YES;
        }
    }
    else if(textField == self.gregorianDayTxt ||
            textField == self.lunarDayTxt){
        NSString *completeStr = [textField.text stringByReplacingCharactersInRange:range
                                                                        withString:string];
        if(completeStr.length>2){
            return NO;
        }
        
        if([completeStr integerValue]>31){
            return NO;
        }
        
        if(string.length>0){
            unichar single = [string characterAtIndex:0];
            if(single >= '0' && single <= '9'){
                return YES;
            }
        }
        else{
            return YES;
        }
    }
    else if(textField == self.gregorianHourTxt ||
            textField == self.lunarHourTxt){
        NSString *completeStr = [textField.text stringByReplacingCharactersInRange:range
                                                                        withString:string];
        if(completeStr.length>2){
            return NO;
        }
        
        if([completeStr integerValue]>=24){
            return NO;
        }
        
        if(string.length>0){
            unichar single = [string characterAtIndex:0];
            if(single >= '0' && single <= '9'){
                return YES;
            }
        }
        else{
            return YES;
        }
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField performSelector:@selector(selectAll:)
                    withObject:textField
                    afterDelay:0];
    [textField selectAll:self];
}

@end
